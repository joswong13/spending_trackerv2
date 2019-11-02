import 'package:spending_tracker/Core/Models/Category.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDatabase {
  static CategoryDatabase _categoryDatabaseHelper;

  Database _categoryDatabase;

  static final String _createCategoryDatabaseString =
      "CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , icon TEXT, colorOne TEXT, colorTwo TEXT)";

  CategoryDatabase._createInstance();

  factory CategoryDatabase() {
    if (_categoryDatabaseHelper == null) {
      _categoryDatabaseHelper = CategoryDatabase._createInstance();
    }
    return _categoryDatabaseHelper;
  }

  /// Returns the database object
  Future<Database> get database async {
    if (_categoryDatabase != null) {
      return _categoryDatabase;
    }
    _categoryDatabase = await getDatabaseInstance();
    return _categoryDatabase;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "category.db");
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(_createCategoryDatabaseString);
  }

  /// Inserts a user transaction into the database.
  Future<void> insertCategory(UserCategory category) async {
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'category',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Updates a user transaction in the database.
  Future<int> updateCategory(UserCategory category) async {
    final Database db = await database;

    int resp = await db.update('category', category.toMap(), where: "id = ?", whereArgs: [category.id]);

    return resp;
  }

  /// Deletes a user transaction from the database.
  Future<int> deleteCategory(int id) async {
    final Database db = await database;

    int resp = await db.delete('category', where: "id = ?", whereArgs: [id]);

    return resp;
  }

  /// Gets all user transactions in the database.
  Future<List<Map<String, dynamic>>> getAllCategoryList() async {
    final Database db = await database;

    return await db.query('category');
  }

  /// Gets all transactions from a particular category and date.
  Future<List<Map<String, dynamic>>> checkCategoryExists(String category) async {
    final Database db = await database;

    return await db.query('category', where: "name = ?", whereArgs: [category]);
  }
}
