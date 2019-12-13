import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';

void main() {
  test("test generate list function", () {
    List<Map<String, dynamic>> iconList = getIconMapAsList();

    expect(iconList.length, 60);
  });

  test("test icon map", () {
    List<Map<String, dynamic>> iconList = getIconMapAsList();

    for (int i = 0; i < iconList.length; i++) {
      IconData iconData = icons[iconList[i]["name"]];
      expect(iconList[i]["icon"], iconData);
    }
  });
}
