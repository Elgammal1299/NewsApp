import 'package:dio/dio.dart';

/// Base Failure Class
abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

/// Server Failure Class for handling Dio Errors
class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  /// Factory constructor to generate failure from DioException
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with the server.');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with the server.');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with the server.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to the server was cancelled.');
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') == true) {
          return ServerFailure('No Internet Connection.');
        }
        return ServerFailure('Unexpected error, Please try again!');
      default:
        return ServerFailure('Oops! There was an error, Please try again.');
    }
  }

  /// Factory constructor to handle server response errors
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (response is Map<String, dynamic>) {
      final String? message = response['message'];
      final dynamic errorsRaw = response['errors'];

      // Common error handling for known status codes
      if (statusCode == 400 ||
          statusCode == 401 ||
          statusCode == 403 ||
          statusCode == 429) {
        if (message != null) {
          return ServerFailure(message);
        } else if (response.containsKey('error')) {
          return ServerFailure(response['error']);
        } else {
          return ServerFailure('Bad Request – Invalid or missing data.');
        }
      }

      // Handle validation errors (422)
      if (statusCode == 422) {
        if (errorsRaw != null && errorsRaw is Map<String, dynamic>) {
          final Map<String, List<String>> validationErrors = {};
          errorsRaw.forEach((key, value) {
            if (value is List) {
              validationErrors[key] = value.map((e) => e.toString()).toList();
            }
          });

          final String combinedErrors = validationErrors.entries
              .map((e) => '${e.key}: ${e.value.join(", ")}')
              .join('\n\n');

          return ServerFailure(
            message ?? 'Validation Error:\n\n$combinedErrors',
          );
        }

        return ServerFailure(message ?? 'Validation Error');
      }
    }

    // Other statuses
    if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    }

    if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later.');
    }

    return ServerFailure('Oops! Something went wrong, Please try again.');
  }
}
