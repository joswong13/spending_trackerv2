import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Models/Month.dart';

void main() {
  test("Month object should exist", () {
    Month month = Month.getInstance;

    month.beginningOfMonthInt = 1;
    month.date = DateTime.utc(2019, 1, 1);
    month.endOfMonthInt = 2;

    expect(month.beginningOfMonthInt, 1);
    expect(month.endOfMonthInt, 2);
    expect(month.date, DateTime.utc(2019, 1, 1));
  });

  test("setDate", () {
    Month month = Month.getInstance;
    DateTime testDate = DateTime.utc(2019, 1, 1);

    setDate(testDate, month);

    expect(month.date, DateTime.utc(2019, 1, 1));
    expect(month.beginningOfMonthInt, 1546300800000);
    expect(month.endOfMonthInt, 1548892800000);
  });
}
