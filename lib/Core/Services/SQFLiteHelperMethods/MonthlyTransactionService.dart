import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/Core/Models/MonthlyTransactionObject.dart';
import '../../Models/UserTransaction.dart';

class StaticMonthlyTransactionObject {
  static Future<MonthlyTransactionObject> createMonthlyTransactionObject(Map<String, dynamic> computeMap) async {
    return _buildMonthlyData(computeMap["tx"], computeMap["listOfCategories"]);
  }
}
//-------------------------StaticMonthlyTransactionObject functions---------------------------------------------------------------------------

///Given the monthly date array and the tx list, builds the monthly view array.
MonthlyTransactionObject _buildMonthlyData(List<Map<String, dynamic>> tx, List<UserCategory> userCategory) {
  MonthlyTransactionObject mto = MonthlyTransactionObject.getInstance;
  //init category map
  mto.monthlyCategoryTotals = _initMonthlyCategoryTotalsMap(userCategory);

  //txMap contains the transactions list from the database converted to a map
  //Map<DateTime, dynamic> txMap = _createTransactionsMapFromList(tx, mto);
  //List<Map<String, dynamic>> txList = _createTransactionsListfromMap(txMap);
  _createTransactionsMapFromList(tx, mto);

  return mto;
}

///Clear and init monthly category map
Map<String, double> _initMonthlyCategoryTotalsMap(List<UserCategory> userCategory) {
  Map<String, double> categoryMap = {};

  for (int i = 0; i < userCategory.length; i++) {
    categoryMap[userCategory[i].name] = 0.0;
  }

  return categoryMap;
}

/// Given a list of user transactions, converts the List<Map<String,dynamic>> to a Map<String,dynamic>.
/// The purpose is to reorganize each transactions by the date it occured.
///
/// Explanation:
/// 1) Save first date in the transactions list to DateTime object called [currentTxDate].
/// 2) If the transaction date is the same as [currentTxDate], add the transactions to the list of daily transactions called [listOfDailyTx].
/// 3) When a transaction no longer has the same transaction as [currentTxDate], add the list of daily transactions to the map [dailyMap]
/// 4) Add [dailyMap] to [txList].
/// 5) Set the [currentTxDate] to the new transaction date, add the trnasaction to [listOfDailyTx].
/// 6) Repeat steps 2 to 5 until no more transactions.
void _createTransactionsMapFromList(List<Map<String, dynamic>> tx, MonthlyTransactionObject mto) {
  double _monthlyTotal = 0.0;
  double dailyTotal = 0.0;
  List<Map<String, dynamic>> txList = [];
  Map<String, double> currentCategoryMap = mto.monthlyCategoryTotals;
  if (tx.length == 0) {
    mto.monthlyTotal = _monthlyTotal;
    mto.txList = txList;
    return;
  }
  //initial values
  DateTime currentTxDate = DateTime.fromMillisecondsSinceEpoch(tx[0]["date"], isUtc: true);
  //List<Map<String, dynamic>> listOfDailyTx = [];
  List<UserTransaction> listOfDailyTx = [];
  //iterate through transactions list to create a map.
  //Big O = (O(n))
  for (int n = 0; n < tx.length; n++) {
    DateTime tempTxDate = DateTime.fromMillisecondsSinceEpoch(tx[n]["date"], isUtc: true);

    _monthlyTotal = _monthlyTotal + tx[n]["amount"];
    _addMonthlyCategoryTotals(tx[n]["category"], tx[n]["amount"], currentCategoryMap);

    if (tempTxDate.isAtSameMomentAs(currentTxDate)) {
      listOfDailyTx.add(UserTransaction.fromDb(tx[n]));
      dailyTotal = dailyTotal + tx[n]["amount"];
    } else {
      //ensure the double is 2 decimal places
      double dailyTotalAmount = double.parse(dailyTotal.toStringAsFixed(2));
      Map<String, dynamic> dailyMap = {
        "date": currentTxDate,
        "dailyTotal": dailyTotalAmount,
        "transactions": listOfDailyTx
      };
      txList.add(dailyMap);

      currentTxDate = tempTxDate;

      listOfDailyTx = new List();

      listOfDailyTx.add(UserTransaction.fromDb(tx[n]));
      dailyTotal = 0.0;
      dailyTotal = dailyTotal + tx[n]["amount"];
    }
  }

  //Add one last time after iterating through the list
  double dailyTotalAmount = double.parse(dailyTotal.toStringAsFixed(2));
  Map<String, dynamic> dailyMap = {
    "date": currentTxDate,
    "dailyTotal": dailyTotalAmount,
    "transactions": listOfDailyTx
  };
  txList.add(dailyMap);
  mto.monthlyTotal = _monthlyTotal;
  mto.txList = txList;
}

///Given the category map, this function will add the current transaction amount to the amount accumulated in the category map.
void _addMonthlyCategoryTotals(String category, double amount, Map<String, double> currentCategoryMap) {
  //ensure the double is 2 decimal places
  double total = currentCategoryMap[category] + amount;

  currentCategoryMap[category] = double.parse(total.toStringAsFixed(2));
}
