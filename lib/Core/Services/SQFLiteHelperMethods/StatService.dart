import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/Core/Models/Stat.dart';

class StaticStatService {
  /// Given a map with a list of user transactions, a list of user categories, the beginning date and end date in millisecondsSinceEpoch,
  /// creates and returns a Stat object.
  static Future<Stat> createStatObject(Map<String, dynamic> computeMap) async {
    return _buildStat(computeMap["tx"], computeMap["listOfCategories"], computeMap["begin"], computeMap["end"]);
  }
}
//-------------------------StaticStatService functions---------------------------------------------------------------------------

/// Given a list of user transactions between certain dates, a list of user categories,
/// the begining and end as an int, create a Stat object.
_buildStat(List<Map<String, dynamic>> tx, List<UserCategory> userCategory, int begin, int end) {
  double _cumulativeTotal = 0.0;
  List<StatCategory> _listOfStatCategory = [];
  List<StatMonth> _listOfStatMonth = [];

  //1) If both category and transactions are empty, then return empty Stat object
  if (tx.length == 0 && userCategory.length == 0) {
    return Stat(_cumulativeTotal, _listOfStatMonth, _listOfStatCategory, tx.length);
  }

  //2) Create StatCategory map to add the totals to each category
  Map<String, StatCategory> _categoryMap = _buildCategoryMap(userCategory);

  //3) Create a map where the key is the month + year and the value is the StatMonth object.
  //eg. The key of March 2019 is 032019.
  Map<String, StatMonth> _monthlyMap = _buildMonthlyMap(begin, end);

  //4) Iterate through each tx, update StatMonth and StatCategory in each map
  //Using a map to easily search at O(1) to update values
  for (int i = 0; i < tx.length; i++) {
    DateTime _tempTxDate = DateTime.fromMillisecondsSinceEpoch(tx[i]["date"], isUtc: true);
    String _monthYear = _tempTxDate.month.toString() + _tempTxDate.year.toString();

    _monthlyMap[_monthYear].total = _monthlyMap[_monthYear].total + tx[i]["amount"];
    _monthlyMap[_monthYear].numberOfTransactions = _monthlyMap[_monthYear].numberOfTransactions + 1;

    _categoryMap[tx[i]["category"]].total = _categoryMap[tx[i]["category"]].total + tx[i]["amount"];
    _categoryMap[tx[i]["category"]].numberOfTransactions = _categoryMap[tx[i]["category"]].numberOfTransactions + 1;

    _cumulativeTotal = _cumulativeTotal + tx[i]["amount"];
  }

  //5) Convert the maps into a List<StatMonth> and List<StatCategory>
  _monthlyMap.forEach((key, value) {
    _listOfStatMonth.add(value);
  });

  _categoryMap.forEach((key, value) {
    _listOfStatCategory.add(value);
  });

  return Stat(_cumulativeTotal, _listOfStatMonth, _listOfStatCategory, tx.length);
}

/// Creates a map where the key is the category name and the value is the StatCategory object.
/// Initialize each category with 0.0 total and 0 transactions.
Map<String, StatCategory> _buildCategoryMap(List<UserCategory> userCategory) {
  Map<String, StatCategory> _categoryMap = {};

  for (int i = 0; i < userCategory.length; i++) {
    _categoryMap[userCategory[i].name] = StatCategory(userCategory[i].name, 0.0, 0, userCategory[i].icon);
  }
  return _categoryMap;
}

/// Creates a map where the key is the month and year and the value is the StatMonth object.
/// Initialize each [StatMonth] with [StatMonth.total] = 0.0,[StatMonth.numberOfTransactions] = 0, and [StatMonth.date] = DateTime object.
/// Eg. The key of March 2019 is "032019".
Map<String, StatMonth> _buildMonthlyMap(int begin, int end) {
  Map<String, StatMonth> _monthlyMap = {};
  int _dateTimeAccumulator = begin;

  while (_dateTimeAccumulator <= end) {
    DateTime _tempDateTime = DateTime.fromMillisecondsSinceEpoch(_dateTimeAccumulator, isUtc: true);

    String _monthYear = _tempDateTime.month.toString() + _tempDateTime.year.toString();

    _monthlyMap[_monthYear] = StatMonth(0.0, 0, _tempDateTime);

    _dateTimeAccumulator = DateTime.utc(_tempDateTime.year, _tempDateTime.month + 1, 1).millisecondsSinceEpoch;
  }

  return _monthlyMap;
}
