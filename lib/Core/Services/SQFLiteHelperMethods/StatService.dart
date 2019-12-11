import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/Core/Models/Stat.dart';

class StaticStatService {
  static Future<Stat> calc(Map<String, dynamic> computeMap) async {
    return _buildStat(computeMap["tx"], computeMap["listOfCategories"], computeMap["begin"], computeMap["end"]);
  }
}

_buildStat(List<Map<String, dynamic>> tx, List<UserCategory> userCategory, int begin, int end) {
  double _cumulativeTotal = 0.0;
  List<StatCategory> _listOfStatCategory = [];
  List<StatMonth> _listOfStatMonth = [];

  //If both category and transactions are empty, then return empty Stat object
  if (tx.length == 0 && userCategory.length == 0) {
    return Stat(_cumulativeTotal, _listOfStatMonth, _listOfStatCategory, tx.length);
  }

  //1) Create StatCategory map
  Map<String, StatCategory> _categoryMap = _buildCategoryMap(userCategory);

  //2) Iterate through each tx, update StatMonth and StatCategory in each map
  //Using a map to easily search at O(1) to update values
  //might need a sort
  Map<String, StatMonth> _monthlyMap = _buildMonthlyMap(begin, end);

  for (int i = 0; i < tx.length; i++) {
    DateTime _tempTxDate = DateTime.fromMillisecondsSinceEpoch(tx[i]["date"], isUtc: true);
    String _monthYear = _tempTxDate.month.toString() + _tempTxDate.year.toString();

    _monthlyMap[_monthYear].total = _monthlyMap[_monthYear].total + tx[i]["amount"];
    _monthlyMap[_monthYear].numberOfTransactions = _monthlyMap[_monthYear].numberOfTransactions + 1;

    _categoryMap[tx[i]["category"]].total = _categoryMap[tx[i]["category"]].total + tx[i]["amount"];
    _categoryMap[tx[i]["category"]].numberOfTransactions = _categoryMap[tx[i]["category"]].numberOfTransactions + 1;

    _cumulativeTotal = _cumulativeTotal + tx[i]["amount"];
  }

  //3) creating stat object

  //Stat()

  _monthlyMap.forEach((key, value) {
    _listOfStatMonth.add(value);
  });

  _categoryMap.forEach((key, value) {
    _listOfStatCategory.add(value);
  });

  return Stat(_cumulativeTotal, _listOfStatMonth, _listOfStatCategory, tx.length);
}

Map<String, StatCategory> _buildCategoryMap(List<UserCategory> userCategory) {
  Map<String, StatCategory> _categoryMap = {};

  for (int i = 0; i < userCategory.length; i++) {
    _categoryMap[userCategory[i].name] = StatCategory(userCategory[i].name, 0.0, 0, userCategory[i].icon);
  }
  return _categoryMap;
}

Map<String, StatMonth> _buildMonthlyMap(int begin, int end) {
  Map<String, StatMonth> _monthlyMap = {};
  int _dateTimeAccumulator = begin;

  while (_dateTimeAccumulator <= end) {
    DateTime _tempDateTime = DateTime.fromMillisecondsSinceEpoch(_dateTimeAccumulator, isUtc: true);

    String _monthYear = _tempDateTime.month.toString() + _tempDateTime.year.toString();

    _monthlyMap[_monthYear] =
        StatMonth(0.0, 0, _tempDateTime.month, _tempDateTime.year, _dateTimeAccumulator, _tempDateTime);

    _dateTimeAccumulator = DateTime.utc(_tempDateTime.year, _tempDateTime.month + 1, 1).millisecondsSinceEpoch;
  }

  return _monthlyMap;
}

// {
//   "1118":{
//     "month": 11,
//     "year": 2018,
//     "total": 0,
//     "numOfTransactions": 0
//   },
//   "1218":{
//     "month": 12,
//     "year": 2018,
//     "total": 0,
//     "numOfTransactions": 0
//   }
// }
// if (_monthlyMap[_monthYear] == null) {
//   _monthlyMap[_monthYear] = StatMonth(tx[i]["amount"], 1, _tempTxDate.month, _tempTxDate.year);
// } else {
// }
