import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/Core/Models/MonthlyTransactionObject.dart';
import 'package:spending_tracker/Core/Models/UserTransaction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spending_tracker/Core/Services/Sqflite/BaseDB.dart';
import 'package:spending_tracker/Core/Services/Sqflite/CategoryDatabaseHelper.dart';
import '../Models/Month.dart';
import '../Services/SQFLiteHelperMethods/MonthlyTransactionService.dart';
import '../Services/Sqflite/TransactionDatabase.dart';

class AppProvider with ChangeNotifier {
  Month monthInstance = Month.getInstance;
  MonthlyTransactionObject dataTable = MonthlyTransactionObject.getInstance;

  //Database
  BaseDB<UserTransaction> transactionDatabase = TransactionDatabase();
  BaseDB<UserCategory> categoryDatabase = CategoryDatabase();

  //Provider variables
  bool _busy = false;
  bool _constructorStatus = false;

  String _categoryType = '';
  List<UserTransaction> _categoryUserTransactionList = [];

  List<UserCategory> _userCategoryList = [];
  Map<String, String> _userCategoryMap = {};
  List<int> _listOfYears = [];

  ///@Constructor
  ///Generate initial calendar and query from database.
  AppProvider() {
    _setConstructorBusy(true);

    for (int i = DateTime.now().year; i >= 2018; i--) {
      _listOfYears.add(i);
    }

    setDate(DateTime.now(), monthInstance);

    //Gets all the categories
    _getAllCategory().then((categoryList) {
      for (int i = 0; i < categoryList.length; i++) {
        _userCategoryList.add(UserCategory.fromDb(categoryList[i]));
        _userCategoryMap[categoryList[i]["name"]] = categoryList[i]["icon"];
      }
    });

    //Gets all the transactions from the start of the month to the end of the month
    _getUserTransactionsBetween().then((listOfUserTx) async {
      Map<String, dynamic> temp = {"tx": listOfUserTx, "listOfCategories": _userCategoryList};

      //Create monthly transaction object
      await compute(StaticMonthlyTransactionObject.calc, temp).then((resp) {
        dataTable = resp;
        _setConstructorBusy(false);
      });
    });
  }

  //----------------------------------------------Core Functions-----------------------------------------
  ///Sets busy status or not busy status during constructor call. The only method used to notify listeners.
  void _setConstructorBusy(bool value) {
    _constructorStatus = value;
    notifyListeners();
  }

  ///Sets busy status or not busy status. The only method used to notify listeners.
  void _setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  ///Sets the date in the month model and then performs the query.
  Future<void> _changeDateAndQuery(DateTime date) async {
    _setBusy(true);
    setDate(date, monthInstance);

    //Query
    //Call build table fcn
    List<Map<String, dynamic>> listOfUserTx = await _getUserTransactionsBetween();

    Map<String, dynamic> temp = {"tx": listOfUserTx, "listOfCategories": _userCategoryList};
    await compute(StaticMonthlyTransactionObject.calc, temp).then((resp) {
      dataTable = resp;
      _setBusy(false);
    });
  }

  //----------------------------------------------Setters-----------------------------------------
  set categoryType(String category) {
    _categoryType = category;
  }

  //----------------------------------------------Getters-----------------------------------------

  ///Used to set widget tree status. Returns the value of the busy status.
  bool get busy {
    return _busy;
  }

  bool get constructorStatus {
    return _constructorStatus;
  }

  List<int> get listOfYears {
    return _listOfYears;
  }

  ///Get the date currently selected.
  DateTime get date {
    return monthInstance.date;
  }

  double get monthlyTotal {
    return dataTable.monthlyTotal;
  }

  ///Returns a maps for each category containing their totals.
  Map<String, dynamic> get monthlyCategoryTotals {
    return dataTable.monthlyCategoryTotals;
  }

  List<UserTransaction> get categoryUserTransactionList {
    return _categoryUserTransactionList;
  }

  ///Returns the txList.
  ///Example of map : {"date": DateTime,"dailyTotal": double,"transactions": List<UserTransaction>}
  List<Map<String, dynamic>> get txList {
    return dataTable.txList;
  }

  List<UserCategory> get userCategoryList {
    return _userCategoryList;
  }

  ///Returns a map containing the category name and category icon.
  Map<String, String> get userCategoryMap {
    return _userCategoryMap;
  }

  //----------------------------------------------External Functions-----------------------------------------

  ///Changes the current date in Provider to the one selected.
  Future<void> changeDate(DateTime date) async {
    await _changeDateAndQuery(date);
  }

  ///Refreshes the current queried transactions after inserting/updating/deleting a transaction.
  ///If the categoryType is not empty, then also get the category transactions.
  Future<void> refreshTransactions() async {
    _setBusy(true);
    setDate(date, monthInstance);

    //Query
    //Call build table fcn
    List<Map<String, dynamic>> listOfUserTx = await _getUserTransactionsBetween();

    Map<String, dynamic> temp = {"tx": listOfUserTx, "listOfCategories": _userCategoryList};

    //if deleting a transaction in the CategoryTransactionView, then this will call getListOfCategoryTransctions()
    if (_categoryType != "") {
      getListOfCategoryTransactions();
    }

    await compute(StaticMonthlyTransactionObject.calc, temp).then((resp) {
      dataTable = resp;
      _setBusy(false);
    });
  }

  Future<void> _refreshUserCategoryList() async {
    _userCategoryMap.clear();
    _userCategoryList.clear();

    await _getAllCategory().then((categoryList) {
      for (int i = 0; i < categoryList.length; i++) {
        _userCategoryList.add(UserCategory.fromDb(categoryList[i]));
        _userCategoryMap[categoryList[i]["name"]] = categoryList[i]["icon"];
      }
    });
    notifyListeners();
  }

  ///Using the categoryType in the MonthProvider object, does a SQL search. Then converts each transaction to a UserTransaction object.
  Future<void> getListOfCategoryTransactions() async {
    _categoryUserTransactionList.clear();

    await _getCategoryList(_categoryType).then((resp) {
      for (int i = 0; i < resp.length; i++) {
        _categoryUserTransactionList.add(UserTransaction.fromDb(resp[i]));
      }
    });
  }

  //----------------------------------------------SQFLite Core Functions-----------------------------------------

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

  ///Insert UserCategory to category db, then refresh the current list of _userCategory and map of _userCategoryMap. Then refresh transactions.
  Future<void> insertCategory(String name, String icon, String colorOne, String colorTwo, int position) async {
    UserCategory category = UserCategory();
    category.name = name.toLowerCase();
    category.icon = icon;
    category.colorOne = colorOne;
    category.colorTwo = colorTwo;
    category.position = position;

    await categoryDatabase.insert(category);

    await _refreshUserCategoryList();
  }

  //------------UPDATE-----------------
  ///Given the id, name, amount, desc, date, and category; update the transaction. Then refresh list of transactions via refreshTransactions();
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

    if (resp == 1) {
      await refreshTransactions();
    }

    return resp;
  }

  ///Given the id, name, amount, desc, date, and category; update the transaction. Then refresh the list of categories via _refreshUserCategoryList().
  Future<int> updateUserCategory(
      int id, String name, String colorOne, String colorTwo, String icon, int position) async {
    UserCategory userCategory = UserCategory();
    userCategory.id = id;
    userCategory.name = name;
    userCategory.colorOne = colorOne;
    userCategory.colorTwo = colorTwo;
    userCategory.icon = icon;
    userCategory.position = position;

    int resp = await categoryDatabase.update(userCategory);

    if (resp == 1) {
      await _refreshUserCategoryList();
    }

    return resp;
  }

  //------------READ-----------------

  Future<List<Map<String, dynamic>>> _getAllCategory() async {
    return await categoryDatabase.getAllInDb();
  }

  Future<bool> categoryExists(String category) async {
    List<Map<String, dynamic>> resp = await categoryDatabase.getWithOneParameter<String>(category);

    if (resp.length > 0) {
      return true;
    }
    return false;
  }

  ///Private function that gets all the user transaction of a particular category.
  Future<List<Map<String, dynamic>>> _getCategoryList(String category) async {
    int beginningOfQuery = monthInstance.beginningOfMonthInt;
    int endOfQuery = monthInstance.endOfMonthInt;

    return await transactionDatabase.getWithThreeParameters<int, int, String>(beginningOfQuery, endOfQuery, category);
  }

  ///Private function that grabs all the transactions between certain dates.
  Future<List<Map<String, dynamic>>> _getUserTransactionsBetween() async {
    int beginningOfQuery = monthInstance.beginningOfMonthInt;
    int endOfQuery = monthInstance.endOfMonthInt;

    return await transactionDatabase.getWithTwoParameters<int, int>(beginningOfQuery, endOfQuery);
  }

  //------------DELETE-----------------
  Future<int> deleteCategory(int id) async {
    int resp = await categoryDatabase.deleteById(id);

    if (resp == 1) {
      await _refreshUserCategoryList();
      await refreshTransactions();
    }

    return resp;
  }

  ///Given the id, delete the transaction from the database.
  Future<int> deleteUserTransaction(int id) async {
    int resp = await transactionDatabase.deleteById(id);

    if (resp == 1) {
      await refreshTransactions();
    }

    return resp;
  }

  ///Given the category, delete all transactions from the database.
  Future<int> deleteAllUserTransactionInCategory(String category) {
    return transactionDatabase.deleteByString(category);
  }

  //------------BATCH-----------------

  /// Given a list of User Categories, iterate through the list and update the database. Then refresh the list of User Categories
  Future<void> batchJobUpdateUserCategory(List<UserCategory> listOfUC) async {
    await categoryDatabase.batchJob(listOfUC);
    await _refreshUserCategoryList();
  }
}

///Gets all the user transaction.
///Not used in any of the widgets.
// Future<List<Map<String, dynamic>>> _getAllUserTransaction() async {
//   return await transactionDatabase.getAllInDb();
// }

// ///Resets the current date in Provider to today.
// Future<void> reset() async {
//   DateTime resetToCurrentDate = DateTime.now();
//   await _changeDateAndQuery(DateTime.utc(resetToCurrentDate.year, resetToCurrentDate.month, resetToCurrentDate.day));
// }
