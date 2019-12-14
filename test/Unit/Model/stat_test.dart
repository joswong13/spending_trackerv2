import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Models/Stat.dart';

void main() {
  test("StatMonth object should exist and changing data", () {
    DateTime date = DateTime.now();
    StatMonth statMonth = StatMonth(0.0, 0, date);

    expect(statMonth.total, 0.0);
    expect(statMonth.numberOfTransactions, 0);
    expect(statMonth.date, date);

    statMonth.total = 888.88;
    statMonth.numberOfTransactions = 15;

    expect(statMonth.total, 888.88);
    expect(statMonth.numberOfTransactions, 15);
  });

  test("StatCategory object should exist and changing data", () {
    StatCategory statCategory = StatCategory("Test", 0.0, 0, "Phone");

    expect(statCategory.total, 0.0);
    expect(statCategory.numberOfTransactions, 0);
    expect(statCategory.category, "Test");
    expect(statCategory.icon, "Phone");

    statCategory.total = 888.88;
    statCategory.numberOfTransactions = 15;

    expect(statCategory.total, 888.88);
    expect(statCategory.numberOfTransactions, 15);
  });

  test("Stat object should exist", () {
    //-------StatMonth--------
    DateTime date = DateTime.utc(2019, 01, 1);
    StatMonth statMonth = StatMonth(0.0, 0, date);

    DateTime date1 = DateTime.utc(2019, 02, 1);
    StatMonth statMonth1 = StatMonth(0.0, 0, date1);

    List<StatMonth> listOfStatMonth = [];
    listOfStatMonth.add(statMonth);
    listOfStatMonth.add(statMonth1);

    //-------StatCategory--------
    StatCategory statCategory = StatCategory("Test", 0.0, 0, "Phone");

    List<StatCategory> listOfStatCategory = [];
    listOfStatCategory.add(statCategory);

    Stat stat = Stat(0.0, listOfStatMonth, listOfStatCategory, 0);

    expect(stat.total, 0.0);
    expect(stat.statMonth.length, 2);
    expect(stat.statCategory.length, 1);
    expect(stat.numberOfTransactions, 0);
  });
}
