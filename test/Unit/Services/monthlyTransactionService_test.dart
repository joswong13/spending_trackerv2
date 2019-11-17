import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/Core/Models/MonthlyTransactionObject.dart';
import 'package:spending_tracker/Core/Models/UserTransaction.dart';
import 'package:spending_tracker/Core/Services/SQFLiteHelperMethods/MonthlyTransactionService.dart';

void main() {
  test("Test input and output of monthly transaction service", () async {
    List<Map<String, dynamic>> listOfUserTx = [
      {
        "id": 1,
        "name": "Test",
        "amount": 1.1,
        "date": 1572566400000,
        "category": "Test",
        "desc": "desc",
        "uploaded": 0
      },
      {"id": 2, "name": "test2", "amount": 2.2, "date": 1572566400000, "category": "Test1", "desc": "", "uploaded": 0},
      {"id": 3, "name": "test3", "amount": 3.3, "date": 1572652800000, "category": "Test", "desc": "", "uploaded": 0},
      {"id": 4, "name": "more", "amount": 4.4, "date": 1572652800000, "category": "Test1", "desc": "", "uploaded": 0},
      {"id": 5, "name": "aaaaa", "amount": 5.5, "date": 1572652800000, "category": "Test1", "desc": "", "uploaded": 0}
    ];
    Map<String, dynamic> fromDb1 = {"id": 1, "name": "Test", "icon": "Icon", "colorOne": "Blue", "colorTwo": "Red"};
    Map<String, dynamic> fromDb2 = {"id": 1, "name": "Test1", "icon": "Icon", "colorOne": "Blue", "colorTwo": "Red"};
    UserCategory uC1 = UserCategory.fromDb(fromDb1);
    UserCategory uC2 = UserCategory.fromDb(fromDb2);
    List<UserCategory> uCList = [uC1, uC2];

    Map<String, dynamic> temp = {"tx": listOfUserTx, "listOfCategories": uCList};

    MonthlyTransactionObject dataTable = MonthlyTransactionObject.getInstance;
    dataTable = await StaticMonthlyTransactionObject.calc(temp);

    UserTransaction uT = dataTable.txList[1]["transactions"][0];
    expect(uT.id, 3);
    expect(uT.category, "Test");
    expect(uT.amount, 3.3);

    expect(dataTable.monthlyTotal, 16.5);
    expect(dataTable.monthlyCategoryTotals, {"Test": 4.4, "Test1": 12.1});
    expect(dataTable.txList[0]["dailyTotal"], 3.3);
    expect(dataTable.txList[1]["dailyTotal"], 13.2);
  });
}
