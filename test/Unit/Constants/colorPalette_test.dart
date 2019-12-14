import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';

void main() {
  test("test generate list function", () {
    List<Map<String, dynamic>> colorList = getColorsMapAsList();
    expect(colorList.length, 90);
  });

  test("test colors map", () {
    List<Map<String, dynamic>> colorList = getColorsMapAsList();

    for (int i = 0; i < colorList.length; i++) {
      Color color = materialColorMap[colorList[i]["name"]];
      expect(colorList[i]["color"], color);
    }
  });
}
