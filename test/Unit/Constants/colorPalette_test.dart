import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';

void main() {
  test("test generate list function", () {
    expect(getColorsMapAsList().length, 90);
  });
}
