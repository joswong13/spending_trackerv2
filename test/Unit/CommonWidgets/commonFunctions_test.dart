import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/CommonFunctions.dart';

void main() {
  test("test single letter capitalization", () {
    expect(upperCaseFirstLetter("s"), "S");
  });

  test("test one word capitalization", () {
    expect(upperCaseFirstLetter("test"), "Test");
  });

  test("test null", () {
    expect(upperCaseFirstLetter(null), "Format Error");
  });
}
