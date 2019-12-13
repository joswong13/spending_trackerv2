import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/Core/Models/Stat.dart';
import 'package:spending_tracker/Core/Services/SQFLiteHelperMethods/StatService.dart';

void main() {
  test("test empty stat service", () async {
    DateTime begin = DateTime.utc(2019, 1, 1);
    DateTime end = DateTime.utc(2019, 12, 31);

    List<UserCategory> listOfUC = [];
    expect(listOfUC.length, 0);

    List<Map<String, dynamic>> listOfTx = [];
    expect(listOfTx.length, 0);

    Map<String, dynamic> temp = {
      "tx": listOfTx,
      "listOfCategories": listOfUC,
      "begin": begin.millisecondsSinceEpoch,
      "end": end.millisecondsSinceEpoch
    };

    Stat stat = await StaticStatService.createStatObject(temp);

    expect(stat.total, 0.0);
    expect(stat.numberOfTransactions, 0);
    expect(stat.statCategory.length, 0);
    expect(stat.statMonth.length, 0);
  });

  test("test creating stat service", () async {
    DateTime begin = DateTime.utc(2019, 1, 1);
    DateTime end = DateTime.utc(2019, 12, 31);

    List<UserCategory> listOfUC = createListOfUC();
    expect(listOfUC.length, 2);

    List<Map<String, dynamic>> listOfTx = createListOfTx();
    expect(listOfTx.length, 4);

    Map<String, dynamic> temp = {
      "tx": listOfTx,
      "listOfCategories": listOfUC,
      "begin": begin.millisecondsSinceEpoch,
      "end": end.millisecondsSinceEpoch
    };

    Stat stat = await StaticStatService.createStatObject(temp);

    expect(stat.total, 62.34);
    expect(stat.statMonth.length, 12);

    expect(stat.statMonth[1].total, 20.00);
    expect(stat.statMonth[1].numberOfTransactions, 2);

    expect(stat.statMonth[2].total, 12.34);
    expect(stat.statMonth[2].numberOfTransactions, 1);

    expect(stat.statMonth[7].total, 30.00);
    expect(stat.statMonth[7].numberOfTransactions, 1);

    expect(stat.statCategory[0].category, "Happy");
    expect(stat.statCategory[0].numberOfTransactions, 2);
    expect(stat.statCategory[0].total, 20.0);

    expect(stat.statCategory[1].category, "More");
    expect(stat.statCategory[1].numberOfTransactions, 2);
    expect(stat.statCategory[1].total, 42.34);
  });
}

List<UserCategory> createListOfUC() {
  List<UserCategory> listOfUC = [];

  UserCategory uc = UserCategory();
  uc.id = 1;
  uc.name = "Happy";
  uc.icon = "Icon";
  uc.colorOne = "Blue";
  uc.colorTwo = "Red";
  uc.position = 0;

  UserCategory uc1 = UserCategory();
  uc1.id = 2;
  uc1.name = "More";
  uc1.icon = "Icon";
  uc1.colorOne = "Blue";
  uc1.colorTwo = "Red";
  uc1.position = 1;

  listOfUC.add(uc);
  listOfUC.add(uc1);

  return listOfUC;
}

List<Map<String, dynamic>> createListOfTx() {
  List<Map<String, dynamic>> listOfTx = [];

  Map<String, dynamic> tx = {
    "id": 1,
    "name": "Transaction1",
    "amount": 12.34,
    "date": 1551398400000,
    "category": "More",
    "desc": "DESC",
    "uploaded": 0
  };
  listOfTx.add(tx);

  Map<String, dynamic> tx1 = {
    "id": 2,
    "name": "Transaction2",
    "amount": 10.00,
    "date": 1551312000000,
    "category": "Happy",
    "desc": "DESC",
    "uploaded": 0
  };
  listOfTx.add(tx1);

  Map<String, dynamic> tx2 = {
    "id": 3,
    "name": "Transaction3",
    "amount": 10.00,
    "date": 1551312000000,
    "category": "Happy",
    "desc": "DESC",
    "uploaded": 0
  };
  listOfTx.add(tx2);

  Map<String, dynamic> tx3 = {
    "id": 4,
    "name": "Transaction4",
    "amount": 30.00,
    "date": 1566950400000,
    "category": "More",
    "desc": "DESC",
    "uploaded": 0
  };
  listOfTx.add(tx3);

  return listOfTx;
}
