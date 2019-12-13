import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/Core/Models/MonthlyTransactionObject.dart';
import 'package:spending_tracker/Core/Models/Stat.dart';
import 'package:spending_tracker/Core/Models/UserTransaction.dart';
import 'package:flutter/foundation.dart';
import 'package:spending_tracker/Core/Services/SQFLiteHelperMethods/StatService.dart';
import 'package:spending_tracker/Core/ViewModels/BaseProvider.dart';
import 'package:spending_tracker/Core/ViewModels/CategoryDBProvider.dart';
import 'package:spending_tracker/Core/ViewModels/TransactionDBProvider.dart';
import '../Models/Month.dart';
import '../Services/SQFLiteHelperMethods/MonthlyTransactionService.dart';

class AppProvider extends BaseProvider with CategoryDBProvider, TransactionDBProvider {
  Month monthInstance = Month.getInstance;
  MonthlyTransactionObject dataTable = MonthlyTransactionObject.getInstance;

  List<UserTransaction> _categoryUserTransactionList = [];

  /// _categoryType gets changed when the user clicks on a category card, used when refreshing transactions if user edits the transaction
  String _categoryType = '';

  /// _userCategoryList contains the full UserCategory object
  List<UserCategory> _userCategoryList = [];

  /// _userCategoryMap contains only the category name and category icon as string {"name": CATEGORY_NAME, "icon": CATEGORY_ICON}
  Map<String, String> _userCategoryMap = {};

  /// _listOfYears contains the years to pass to the dialog when quick selecting dates
  List<int> _listOfYears = [];

  DateTime _forwardLimit;
  DateTime _backwardLimit;

  ///@Constructor
  ///Generate initial calendar and query from database.
  AppProvider() {
    constructorBusy = true;

    for (int i = DateTime.now().year; i >= 2018; i--) {
      _listOfYears.add(i);
    }

    _forwardLimit = DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 0);
    _backwardLimit = DateTime.utc(2017, 12, 31);

    setDate(DateTime.now(), monthInstance);

    //Gets all the categories
    getAllCategory().then((categoryList) {
      for (int i = 0; i < categoryList.length; i++) {
        _userCategoryList.add(UserCategory.fromDb(categoryList[i]));
        _userCategoryMap[categoryList[i]["name"]] = categoryList[i]["icon"];
      }
    });

    //Gets all the transactions from the start of the month to the end of the month
    getUserTransactionsBetween(monthInstance.beginningOfMonthInt, monthInstance.endOfMonthInt)
        .then((listOfUserTx) async {
      Map<String, dynamic> temp = {"tx": listOfUserTx, "listOfCategories": _userCategoryList};

      //Create monthly transaction object
      await compute(StaticMonthlyTransactionObject.createMonthlyTransactionObject, temp).then((resp) {
        dataTable = resp;
        constructorBusy = false;
      });
    });
  }

  //----------------------------------------------Core Functions-----------------------------------------

  ///Sets the date in the month model and then performs the query.
  Future<void> _changeDateAndQuery(DateTime date) async {
    busy = true;
    setDate(date, monthInstance);

    //Query
    //Call build table fcn
    List<Map<String, dynamic>> listOfUserTx =
        await getUserTransactionsBetween(monthInstance.beginningOfMonthInt, monthInstance.endOfMonthInt);

    Map<String, dynamic> temp = {"tx": listOfUserTx, "listOfCategories": _userCategoryList};
    await compute(StaticMonthlyTransactionObject.createMonthlyTransactionObject, temp).then((resp) {
      dataTable = resp;
      busy = false;
    });
  }

  //----------------------------------------------Setters-----------------------------------------
  set categoryType(String category) {
    _categoryType = category;
  }

  //----------------------------------------------Getters-----------------------------------------

  List<int> get listOfYears {
    return List.unmodifiable(_listOfYears);
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

  DateTime get forwardLimit {
    return _forwardLimit;
  }

  DateTime get backwardLimit {
    return _backwardLimit;
  }

  //----------------------------------------------External Functions-----------------------------------------

  ///Changes the current date in Provider to the one selected.
  Future<void> changeDate(DateTime date) async {
    await _changeDateAndQuery(date);
  }

  ///Using the categoryType in the MonthProvider object, does a SQL search. Then converts each transaction to a UserTransaction object.
  Future<void> getListOfCategoryTransactions() async {
    _categoryUserTransactionList.clear();

    await getCategoryList(monthInstance.beginningOfMonthInt, monthInstance.endOfMonthInt, _categoryType).then((resp) {
      for (int i = 0; i < resp.length; i++) {
        _categoryUserTransactionList.add(UserTransaction.fromDb(resp[i]));
      }
    });
  }

  Future<Stat> getStatsView(int begin, int end) async {
    Stat stat;
    List<Map<String, dynamic>> res = await getUserTransactionsBetween(begin, end);

    Map<String, dynamic> temp = {"tx": res, "listOfCategories": _userCategoryList, "begin": begin, "end": end};

    await compute(StaticStatService.createStatObject, temp).then((resp) {
      stat = resp;
    });

    return stat;
  }

//---------------------------------------REFRESH METHODS---------------------------------------------------------------

  /// Refreshes the current queried transactions after inserting/updating/deleting a transaction.
  /// If the categoryType is not empty, then also get the category transactions.
  Future<void> refreshTransactions() async {
    busy = true;
    setDate(date, monthInstance);

    //Query
    //Call build table fcn

    List<Map<String, dynamic>> listOfUserTx =
        await getUserTransactionsBetween(monthInstance.beginningOfMonthInt, monthInstance.endOfMonthInt);

    Map<String, dynamic> temp = {"tx": listOfUserTx, "listOfCategories": _userCategoryList};

    //if deleting a transaction in the CategoryTransactionView, then this will call getListOfCategoryTransctions()
    if (_categoryType != "") {
      getListOfCategoryTransactions();
    }

    await compute(StaticMonthlyTransactionObject.createMonthlyTransactionObject, temp).then((resp) {
      dataTable = resp;
      busy = false;
    });
  }

  /// Refreshed the category list after editing, adding, or deleting a category
  Future<void> refreshUserCategoryList() async {
    _userCategoryMap.clear();
    _userCategoryList.clear();

    await getAllCategory().then((categoryList) {
      for (int i = 0; i < categoryList.length; i++) {
        _userCategoryList.add(UserCategory.fromDb(categoryList[i]));
        _userCategoryMap[categoryList[i]["name"]] = categoryList[i]["icon"];
      }
    });
    notifyListeners();
  }
}
