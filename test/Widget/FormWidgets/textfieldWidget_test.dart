import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/TextfieldWidget.dart';

void main() {
  test("Test remove spacing from strings", () {
    double resp = parseDoubleFromController("This should be null");
    expect(resp, null);
  });
  test("Test remove spacing from string amount", () {
    double resp = parseDoubleFromController("123 45 .88");
    expect(resp, 12345.88);
  });
}
