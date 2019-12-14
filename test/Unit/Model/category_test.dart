import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Models/Category.dart';

void main() {
  group("UserCategory Tests", () {
    test("UserCategory object should exist", () {
      UserCategory uc = UserCategory();
      uc.id = 1;
      uc.name = "Test";
      uc.icon = "Icon";
      uc.colorOne = "Blue";
      uc.colorTwo = "Red";
      uc.position = 0;

      expect(uc.id, 1);
      expect(uc.name, "Test");
      expect(uc.icon, "Icon");
      expect(uc.colorOne, "Blue");
      expect(uc.colorTwo, "Red");
      expect(uc.position, 0);
    });

    test("toMap", () {
      UserCategory uc = UserCategory();
      uc.id = 1;
      uc.name = "Test";
      uc.icon = "Icon";
      uc.colorOne = "Blue";
      uc.colorTwo = "Red";
      uc.position = 0;

      expect(
          uc.toMap(), {"id": 1, "name": "Test", "icon": "Icon", "colorOne": "Blue", "colorTwo": "Red", "position": 0});
    });

    test("fromDb", () {
      Map<String, dynamic> fromDb = {
        "id": 1,
        "name": "Test",
        "icon": "Icon",
        "colorOne": "Blue",
        "colorTwo": "Red",
        "position": 0
      };
      UserCategory uc = UserCategory.fromDb(fromDb);

      expect(uc.id, 1);
      expect(uc.name, "Test");
      expect(uc.icon, "Icon");
      expect(uc.colorOne, "Blue");
      expect(uc.colorTwo, "Red");
      expect(uc.position, 0);
    });

    test("test checkEqual function", () {
      Map<String, dynamic> fromDb = {
        "id": 1,
        "name": "Test",
        "icon": "Icon",
        "colorOne": "Blue",
        "colorTwo": "Red",
        "position": 0
      };

      Map<String, dynamic> fromDb1 = {
        "id": 1,
        "name": "Test",
        "icon": "Icon",
        "colorOne": "Blue",
        "colorTwo": "Red",
        "position": 0
      };

      Map<String, dynamic> fromDb2 = {
        "id": 1,
        "name": "Test",
        "icon": "Icon",
        "colorOne": "Blue",
        "colorTwo": "Red",
        "position": 2
      };
      UserCategory uc = UserCategory.fromDb(fromDb);
      UserCategory uc1 = UserCategory.fromDb(fromDb1);
      UserCategory uc2 = UserCategory.fromDb(fromDb2);

      expect(uc.checkEqual(uc1), true);
      expect(uc.checkEqual(uc2), false);
    });
  });
}
