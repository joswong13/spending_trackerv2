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

      expect(uc.id, 1);
      expect(uc.name, "Test");
      expect(uc.icon, "Icon");
      expect(uc.colorOne, "Blue");
      expect(uc.colorTwo, "Red");
    });

    test("toMap", () {
      UserCategory uc = UserCategory();
      uc.id = 1;
      uc.name = "Test";
      uc.icon = "Icon";
      uc.colorOne = "Blue";
      uc.colorTwo = "Red";

      expect(uc.toMap(), {"id": 1, "name": "Test", "icon": "Icon", "colorOne": "Blue", "colorTwo": "Red"});
    });

    test("fromDb", () {
      Map<String, dynamic> fromDb = {"id": 1, "name": "Test", "icon": "Icon", "colorOne": "Blue", "colorTwo": "Red"};
      UserCategory uc = UserCategory.fromDb(fromDb);

      expect(uc.id, 1);
      expect(uc.name, "Test");
      expect(uc.icon, "Icon");
      expect(uc.colorOne, "Blue");
      expect(uc.colorTwo, "Red");
    });
  });
}
