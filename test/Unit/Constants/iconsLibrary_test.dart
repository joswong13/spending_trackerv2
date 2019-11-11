import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';

void main() {
  test("test generate list function", () {
    expect(getIconMapAsList().length, 60);
  });
}
