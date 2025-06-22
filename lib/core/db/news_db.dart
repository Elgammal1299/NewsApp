import 'dart:developer';

import 'package:news_app/core/model/news_local.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NewsDatabase {
  static final NewsDatabase instance = NewsDatabase._internal();
  NewsDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'new.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
  CREATE TABLE top_headlines (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    url TEXT NOT NULL,
    urlToImage TEXT,
    publishedAt TEXT NOT NULL,
    content TEXT,
    author TEXT,
    sourceName TEXT
  )
''');

    await db.execute('''
  CREATE TABLE recommended_news (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    url TEXT NOT NULL,
    urlToImage TEXT,
    publishedAt TEXT NOT NULL,
    content TEXT,
    author TEXT,
    sourceName TEXT
  )
''');
  }

  Future<void> insertNewsList(
    String tableName,
    List<NewsLocal> newsList,
  ) async {
    final db = await database;
    // await db.delete(tableName);

    final batch = db.batch();
    for (var news in newsList) {
      batch.insert(
        tableName,
        news.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await batch.commit(noResult: true);
  }

  // 📤 جلب كل الأخبار
  Future<List<NewsLocal>> getAllNews(String tableName) async {
    final db = await database;
    final result = await db.query(tableName);
    return result.map((map) {
      log('NewsLocal: ${map.toString()}');
      return NewsLocal.fromMap(map);
    }).toList();
  }

  // ❌ حذف خبر باستخدام id
  Future<int> deleteNews(int id) async {
    final db = await database;
    return await db.delete('news', where: 'id = ?', whereArgs: [id]);
  }

  // 📛 إغلاق القاعدة
  Future close() async {
    final db = await database;
    db.close();
  }
}
