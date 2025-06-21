import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/feature/home/ui/view/widget/custom_carouse_item.dart';
import 'package:news_app/feature/home/ui/view_model/top_headlines_cubit/top_headlines_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomCarouseItem(),
          BlocBuilder<TopHeadlinesCubit, TopHeadlinesState>(
            builder: (context, state) {
              switch (state) {
                case TopHeadlinesInitial():
                  return SizedBox.shrink();
                case TopHeadlinesLoading():
                  return Center(child: CircularProgressIndicator());

                case TopHeadlinesSuccess():
                  final data = state.artical;
                  return Text(data[0].source.name ?? '');

                case TopHeadlinesError():
                  return Text(state.errMessage);
              }
            },
          ),
        ],
      ),
    );
  }
}
