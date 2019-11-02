import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Models/UserTransaction.dart';

void main() {
  test("User Transaction object should exist", () {
    UserTransaction object = UserTransaction();
    object.id = 1;
    object.name = "Transaction Name";
    object.amount = 12.34;
    object.date = 1546300800000;
    object.category = "Category1";
    object.desc = "DESC";
    object.uploaded = 0;

    expect(object.id, 1);
    expect(object.name, "Transaction Name");
    expect(object.amount, 12.34);
    expect(object.date, 1546300800000);
    expect(object.category, "Category1");
    expect(object.desc, "DESC");
    expect(object.uploaded, 0);
  });

  test("User Transaction object toMap", () {
    UserTransaction object = UserTransaction();
    object.id = 1;
    object.name = "Transaction Name";
    object.amount = 12.34;
    object.date = 1546300800000;
    object.category = "Category1";
    object.desc = "DESC";
    object.uploaded = 0;

    expect(object.toMap(), {
      "id": 1,
      "name": "Transaction Name",
      "amount": 12.34,
      "date": 1546300800000,
      "category": "Category1",
      "desc": "DESC",
      "uploaded": 0
    });
  });

  test("User Transaction object fromDb", () {
    Map<String, dynamic> dbResult = {
      "id": 1,
      "name": "Transaction Name",
      "amount": 12.34,
      "date": 1546300800000,
      "category": "Category1",
      "desc": "DESC",
      "uploaded": 0
    };

    UserTransaction object = UserTransaction.fromDb(dbResult);

    expect(object.id, 1);
    expect(object.name, "Transaction Name");
    expect(object.amount, 12.34);
    expect(object.date, 1546300800000);
    expect(object.category, "Category1");
    expect(object.desc, "DESC");
    expect(object.uploaded, 0);
  });
}
