import 'package:spending_tracker/Core/Models/UserTransaction.dart';
import 'package:spending_tracker/Core/Services/Sqflite/BaseDB.dart';
import 'package:spending_tracker/Core/Services/Sqflite/TransactionDatabase.dart';

mixin TransactionDBProvider {
  BaseDB<UserTransaction> transactionDatabase = TransactionDatabase();

//------------INSERT-----------------
  ///Given the name, amount, desc, date, and category; insert into the database as an UserTransaction object.
  Future<void> insertUserTransaction(String name, double amount, String desc, DateTime date, String category) {
    UserTransaction tx = UserTransaction();
    tx.name = name;
    tx.amount = amount;
    tx.desc = desc;
    tx.date = date.millisecondsSinceEpoch;
    tx.category = category;
    tx.uploaded = 0;

    return transactionDatabase.insert(tx);
  }

  //------------UPDATE-----------------
  ///Given the id, name, amount, desc, date, and category; update the transaction.
  Future<int> updateUserTransaction(
      int id, String name, double amount, String desc, DateTime date, String category, int uploaded) async {
    UserTransaction tx = UserTransaction();
    tx.id = id;
    tx.name = name;
    tx.amount = amount;
    tx.desc = desc;
    tx.date = date.millisecondsSinceEpoch;
    tx.category = category;
    tx.uploaded = uploaded;

    int resp = await transactionDatabase.update(tx);
    return resp;
  }

  //------------READ-----------------

  ///Private function that gets all the user transaction of a particular category.
  Future<List<Map<String, dynamic>>> getCategoryList(int beginningOfQuery, int endOfQuery, String category) async {
    return await transactionDatabase.getWithThreeParameters<int, int, String>(beginningOfQuery, endOfQuery, category);
  }

  ///Private function that grabs all the transactions between certain dates.
  Future<List<Map<String, dynamic>>> getUserTransactionsBetween(int beginningOfQuery, int endOfQuery) async {
    return await transactionDatabase.getWithTwoParameters<int, int>(beginningOfQuery, endOfQuery);
  }

  ///Given the id, delete the transaction from the database.
  Future<int> deleteUserTransaction(int id) async {
    int resp = await transactionDatabase.deleteById(id);

    return resp;
  }

  ///Given the category, delete all transactions from the database.
  Future<int> deleteAllUserTransactionInCategory(String category) {
    return transactionDatabase.deleteByString(category);
  }
}
