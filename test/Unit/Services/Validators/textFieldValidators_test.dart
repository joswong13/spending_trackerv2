import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Constants/ErrorCode.dart';
import 'package:spending_tracker/Core/Services/Validators/TextFieldValidators.dart';

void main() {
  group("Textfield form validator", () {
    test("Should give amount error for empty amount", () {
      DateTime newDate;
      Map<String, dynamic> resp =
          validateTransactionFields(name: "", desc: "", amount: "", category: "", date: newDate);
      expect(resp["valid"], false);
      expect(resp["error"], ERR_TX_AMOUNT_PARSE_ERROR);
    });

    test("Should give name error for empty name", () {
      DateTime newDate;
      Map<String, dynamic> resp =
          validateTransactionFields(name: "", desc: "", amount: "18.88", category: "", date: newDate);
      expect(resp["valid"], false);
      expect(resp["error"], ERR_TX_NAME_EMPTY);
    });

    test("Should give name error for long name", () {
      DateTime newDate;
      Map<String, dynamic> resp = validateTransactionFields(
          name: "This name is way too long to be in the name", desc: "", amount: "18.88", category: "", date: newDate);
      expect(resp["valid"], false);
      expect(resp["error"], ERR_TX_NAME_TOO_LONG);
    });

    test("Should give desc error for long description", () {
      DateTime newDate;
      Map<String, dynamic> resp = validateTransactionFields(
          name: "name",
          desc: "This is way too long to be in the description",
          amount: "18.88",
          category: "",
          date: newDate);
      expect(resp["valid"], false);
      expect(resp["error"], ERR_TX_DESC_TOO_LONG);
    });

    test("Should give date error", () {
      DateTime newDate;
      Map<String, dynamic> resp = validateTransactionFields(
          name: "name", desc: "Regular Desc", amount: "18.88", category: "Test", date: newDate);
      expect(resp["valid"], false);
      expect(resp["error"], ERR_TX_DATE_NULL);
    });

    test("Should give category error for default category", () {
      DateTime newDate = DateTime.now();
      Map<String, dynamic> resp = validateTransactionFields(
          name: "name", desc: "Regular Desc", amount: "18.88", category: "None", date: newDate);
      expect(resp["valid"], false);
      expect(resp["error"], ERR_TX_CAT_NULL);
    });

    test("Should give amount error for negative amount", () {
      DateTime newDate = DateTime.now();
      Map<String, dynamic> resp = validateTransactionFields(
          name: "name", desc: "Regular Desc", amount: "-18.88", category: "Test", date: newDate);
      expect(resp["valid"], false);
      expect(resp["error"], ERR_TX_AMOUNT_DOUBLE_ERROR);
    });

    test("Should be valid", () {
      DateTime newDate = DateTime.now();
      Map<String, dynamic> resp = validateTransactionFields(
          name: "name", desc: "Regular Desc", amount: "18.88", category: "Test", date: newDate);
      expect(resp["valid"], true);
    });
  });

  group("Category Validator", () {
    test("Should give category name error for being empty", () {
      Map<String, dynamic> resp = validateCategoryFields(name: "", categoryIcon: "");
      expect(resp["valid"], false);
      expect(resp["error"], ERR_CAT_NAME_EMPTY);
    });

    test("Should give category name error for being too long", () {
      Map<String, dynamic> resp = validateCategoryFields(name: "Category Name", categoryIcon: "");
      expect(resp["valid"], false);
      expect(resp["error"], ERR_CAT_NAME_TOO_LONG);
    });

    test("Should give category icon error for being empty", () {
      Map<String, dynamic> resp = validateCategoryFields(name: "Name", categoryIcon: "");
      expect(resp["valid"], false);
      expect(resp["error"], ERR_CAT_ICON_NULL);
    });

    test("Should validate true", () {
      Map<String, dynamic> resp = validateCategoryFields(name: "Name", categoryIcon: "Shopping");
      expect(resp["valid"], true);
    });
  });
}
