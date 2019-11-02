class MonthlyTransactionObject {
  //Map<DateTime, dynamic> _monthlyTransactions;
  double _sixWeekTotal = 0.0;
  Map<String, double> _monthlyCategoryTotals = {};
  List<Map<String, dynamic>> _txList = [];

  MonthlyTransactionObject._privateConstructor();

  static final MonthlyTransactionObject getInstance = MonthlyTransactionObject._privateConstructor();

  set monthlyCategoryTotals(Map<String, double> monthlyCategoryTotals) {
    _monthlyCategoryTotals.clear();
    _monthlyCategoryTotals = monthlyCategoryTotals;
  }

  set sixWeekTotal(double total) {
    _sixWeekTotal = total;
  }

  set txList(txList) {
    _txList = txList;
  }

  ///Get current six week total
  double get sixWeekTotal {
    return double.parse(_sixWeekTotal.toStringAsFixed(2));
  }

  Map<String, double> get monthlyCategoryTotals {
    return _monthlyCategoryTotals;
  }

  List<Map<String, dynamic>> get txList {
    return _txList;
  }
}

// List<Map<String, dynamic>> get monthlyCategoryTotalsAsList {
//   List<Map<String, dynamic>> categoryList = [];
//   _monthlyCategoryTotals.forEach((String category, double amount) {
//     Map<String, dynamic> temp = {"category": category, "amount": amount};
//     categoryList.add(temp);
//   });

//   return categoryList;
// }
