import '../../Models/UserTransaction.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'BaseDB.dart';

class TransactionDatabase extends BaseDB<UserTransaction> {
  static TransactionDatabase _databaseHelper;
  Database _database;
  static final String _createDatabaseString =
      "CREATE TABLE userTransaction (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, amount REAL, date INTEGER, category TEXT, desc TEXT, uploaded INTEGER)";

  TransactionDatabase._createInstance();

  factory TransactionDatabase() {
    if (_databaseHelper == null) {
      _databaseHelper = TransactionDatabase._createInstance();
    }
    return _databaseHelper;
  }

  /// Returns the database object
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "userTransaction.db");
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(_createDatabaseString);
  }

//---------------------------------------------INSERT---------------------------------------------------------

  @override
  Future<void> insert(UserTransaction tx) async {
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'userTransaction',
      tx.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//---------------------------------------------UPDATE---------------------------------------------------------

  @override
  Future<int> update(UserTransaction tx) async {
    final Database db = await database;

    int resp = await db.update('userTransaction', tx.toMap(), where: "id = ?", whereArgs: [tx.id]);

    return resp;
  }

//---------------------------------------------GET---------------------------------------------------------

  @override
  Future<List<Map<String, dynamic>>> getAllInDb() async {
    final Database db = await database;

    return await db.query('userTransaction');
  }

  @override
  Future<List<Map<String, dynamic>>> getWithOneParameter<A>(A filterOne) {
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> getWithTwoParameters<A, B>(A startOfMonth, B endOfMonth) async {
    final Database db = await database;

    return await db.query('userTransaction',
        where: "date >= ? AND date <= ?", whereArgs: [startOfMonth, endOfMonth], orderBy: "date ASC");
  }

  @override
  Future<List<Map<String, dynamic>>> getWithThreeParameters<A, B, C>(A startOfMonth, B endOfMonth, C category) async {
    final Database db = await database;

    return await db.query('userTransaction',
        where: "date >= ? AND date <= ? AND category = ?",
        whereArgs: [startOfMonth, endOfMonth, category],
        orderBy: "date ASC");
  }

//---------------------------------------------DELETE---------------------------------------------------------

  @override
  Future<int> deleteById(int id) async {
    final Database db = await database;

    int resp = await db.delete('userTransaction', where: "id = ?", whereArgs: [id]);

    return resp;
  }

  @override
  Future<int> deleteByString(String category) async {
    final Database db = await database;

    int resp = await db.delete('userTransaction', where: "category = ?", whereArgs: [category]);

    return resp;
  }
}

// class TransactionDatabase {
//   static TransactionDatabase _databaseHelper;
//   Database _database;
//   static final String _createDatabaseString =
//       "CREATE TABLE userTransaction (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, amount REAL, date INTEGER, category TEXT, desc TEXT, uploaded INTEGER)";

//   TransactionDatabase._createInstance();

//   factory TransactionDatabase() {
//     if (_databaseHelper == null) {
//       _databaseHelper = TransactionDatabase._createInstance();
//     }
//     return _databaseHelper;
//   }

//   /// Returns the database object
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database;
//     }
//     _database = await getDatabaseInstance();
//     return _database;
//   }

//   Future<Database> getDatabaseInstance() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, "userTransaction.db");
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }

//   void _createDB(Database db, int version) async {
//     await db.execute(_createDatabaseString);
//   }

// //---------------------------------------------INSERT---------------------------------------------------------
//   /// Inserts a user transaction into the database.
//   Future<void> insertUserTransaction(UserTransaction tx) async {
//     // Get a reference to the database.
//     final Database db = await database;

//     await db.insert(
//       'userTransaction',
//       tx.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

// //---------------------------------------------UPDATE---------------------------------------------------------
//   /// Updates a user transaction in the database.
//   Future<int> updateUserTransaction(UserTransaction tx) async {
//     final Database db = await database;

//     int resp = await db.update('userTransaction', tx.toMap(), where: "id = ?", whereArgs: [tx.id]);

//     return resp;
//   }

// //---------------------------------------------GET---------------------------------------------------------
//   /// Gets all user transactions in the database.
//   Future<List<Map<String, dynamic>>> getAllUserTransactionList() async {
//     final Database db = await database;

//     return await db.query('userTransaction');
//   }

//   /// Gets all user transactions between two dates that is in millisecondsFromEpoch.
//   Future<List<Map<String, dynamic>>> getUserTransactionsBetween(int startOfMonth, int endOfMonth) async {
//     final Database db = await database;

//     return await db.query('userTransaction',
//         where: "date >= ? AND date <= ?", whereArgs: [startOfMonth, endOfMonth], orderBy: "date ASC");
//   }

//   /// Gets all transactions from a particular category and date.
//   Future<List<Map<String, dynamic>>> getCategoryList(int startOfMonth, int endOfMonth, String category) async {
//     final Database db = await database;

//     return await db.query('userTransaction',
//         where: "date >= ? AND date <= ? AND category = ?",
//         whereArgs: [startOfMonth, endOfMonth, category],
//         orderBy: "date ASC");
//   }

// //---------------------------------------------DELETE---------------------------------------------------------
//   /// Deletes a user transaction from the database.
//   Future<int> deleteUserTransaction(int id) async {
//     final Database db = await database;

//     int resp = await db.delete('userTransaction', where: "id = ?", whereArgs: [id]);

//     return resp;
//   }

//   /// Deletes a user transaction from the database.
//   Future<int> deleteAllUserTransactionInCategory(String category) async {
//     final Database db = await database;

//     int resp = await db.delete('userTransaction', where: "category = ?", whereArgs: [category]);

//     return resp;
//   }
// }
