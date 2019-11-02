import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Models/MonthlyTransactionObject.dart';

void main() {
  test("Month transaction object should exist", () {
    MonthlyTransactionObject object = MonthlyTransactionObject.getInstance;
    expect(object.sixWeekTotal, 0.0);

    object.sixWeekTotal = 5.68;
    Map<String, double> categoryTotalMap = {"Category1": 150.00, "Category2": 123.45};
    object.monthlyCategoryTotals = categoryTotalMap;

    List<Map<String, dynamic>> txList = [];

    object.txList = txList;

    expect(object.sixWeekTotal, 5.68);
    expect(object.monthlyCategoryTotals, {"Category1": 150.00, "Category2": 123.45});
    expect(object.txList, []);
  });
}
