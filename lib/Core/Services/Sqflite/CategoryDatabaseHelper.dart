import 'package:spending_tracker/Core/Models/Category.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'BaseDB.dart';

class CategoryDatabase extends BaseDB<UserCategory> {
  static CategoryDatabase _categoryDatabaseHelper;

  Database _categoryDatabase;

  static final String _createCategoryDatabaseStringV1 =
      "CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , icon TEXT, colorOne TEXT, colorTwo TEXT)";
  static final String _createCategoryDatabaseStringV2 =
      "CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , icon TEXT, colorOne TEXT, colorTwo TEXT, position INTEGER DEFAULT 0)";

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
    return await openDatabase(path, version: 2, onCreate: _createDB, onUpgrade: _onUpgradeDB);
  }

//onUpgrade: _onUpgradeDB
  void _createDB(Database db, int version) async {
    await db.execute(_createCategoryDatabaseStringV2);
  }

  void _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      print("upgrade called");
      await db.execute("ALTER TABLE category ADD COLUMN position INTEGER DEFAULT 0");

      print("DONE UPGRADE");
    }
  }

//---------------------------------------------INSERT---------------------------------------------------------

  @override
  Future<void> insert(UserCategory category) async {
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'category',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//---------------------------------------------UPDATE---------------------------------------------------------

  @override
  Future<int> update(UserCategory category) async {
    final Database db = await database;

    int resp = await db.update('category', category.toMap(), where: "id = ?", whereArgs: [category.id]);

    return resp;
  }

//---------------------------------------------GET---------------------------------------------------------

  @override
  Future<List<Map<String, dynamic>>> getAllInDb() async {
    final Database db = await database;

    return await db.query('category');
  }

  @override
  Future<List<Map<String, dynamic>>> getWithOneParameter<A>(A category) async {
    final Database db = await database;

    return await db.query('category', where: "name = ?", whereArgs: [category]);
  }

  @override
  Future<List<Map<String, dynamic>>> getWithTwoParameters<A, B>(A filterOne, B filterTwo) {
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> getWithThreeParameters<A, B, C>(A filterOne, B filterTwo, C filterThree) {
    return null;
  }

//---------------------------------------------DELETE---------------------------------------------------------

  @override
  Future<int> deleteById(int id) async {
    final Database db = await database;

    int resp = await db.delete('category', where: "id = ?", whereArgs: [id]);

    return resp;
  }

  @override
  Future<int> deleteByString(String s) {
    return null;
  }
}

// class CategoryDatabase {
//   static CategoryDatabase _categoryDatabaseHelper;

//   Database _categoryDatabase;

//   static final String _createCategoryDatabaseString =
//       "CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , icon TEXT, colorOne TEXT, colorTwo TEXT)";

//   CategoryDatabase._createInstance();

//   factory CategoryDatabase() {
//     if (_categoryDatabaseHelper == null) {
//       _categoryDatabaseHelper = CategoryDatabase._createInstance();
//     }
//     return _categoryDatabaseHelper;
//   }

//   /// Returns the database object
//   Future<Database> get database async {
//     if (_categoryDatabase != null) {
//       return _categoryDatabase;
//     }
//     _categoryDatabase = await getDatabaseInstance();
//     return _categoryDatabase;
//   }

//   Future<Database> getDatabaseInstance() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, "category.db");
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }

//   void _createDB(Database db, int version) async {
//     await db.execute(_createCategoryDatabaseString);
//   }

// //---------------------------------------------INSERT---------------------------------------------------------
//   /// Inserts a user transaction into the database.
//   Future<void> insertCategory(UserCategory category) async {
//     // Get a reference to the database.
//     final Database db = await database;

//     await db.insert(
//       'category',
//       category.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

// //---------------------------------------------UPDATE---------------------------------------------------------
//   /// Updates a user transaction in the database.
//   Future<int> updateCategory(UserCategory category) async {
//     final Database db = await database;

//     int resp = await db.update('category', category.toMap(), where: "id = ?", whereArgs: [category.id]);

//     return resp;
//   }

// //---------------------------------------------GET---------------------------------------------------------
//   /// Gets all user transactions in the database.
//   Future<List<Map<String, dynamic>>> getAllCategoryList() async {
//     final Database db = await database;

//     return await db.query('category');
//   }

//   /// Gets all transactions from a particular category and date.
//   Future<List<Map<String, dynamic>>> checkCategoryExists(String category) async {
//     final Database db = await database;

//     return await db.query('category', where: "name = ?", whereArgs: [category]);
//   }

// //---------------------------------------------DELETE---------------------------------------------------------
//   /// Deletes a user transaction from the database.
//   Future<int> deleteCategory(int id) async {
//     final Database db = await database;

//     int resp = await db.delete('category', where: "id = ?", whereArgs: [id]);

//     return resp;
//   }
// }
