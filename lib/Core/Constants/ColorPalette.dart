import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Color darkGrey = Color.fromRGBO(33, 33, 33, 1);
const Color primaryGreen = Color(0xFF4ACFAC);

const Map<String, Color> materialColorMap = {
  "pink100": Color(0xfff8bbd0),
  "pink200": Color(0xfff48fb1),
  "pink300": Color(0xfff06292),
  "pink400": Color(0xffec407a),
  "pink500": Color(0xffe91e63),
  "pink600": Color(0xffd81b60),
  "pink700": Color(0xffc2185b),
  "pink800": Color(0xffad1457),
  "pink900": Color(0xff880e4f),
  "red100": Color(0xffffcdd2),
  "red200": Color(0xffef9a9a),
  "red300": Color(0xffe57373),
  "red400": Color(0xffef5350),
  "red500": Color(0xfff44336),
  "red600": Color(0xffe53935),
  "red700": Color(0xffd32f2f),
  "red800": Color(0xffc62828),
  "red900": Color(0xffb71c1c),
  "orange100": Color(0xffffe0b2),
  "orange200": Color(0xffffcc80),
  "orange300": Color(0xffffb74d),
  "orange400": Color(0xffffa726),
  "orange500": Color(0xffff9800),
  "orange600": Color(0xfffb8c00),
  "orange700": Color(0xfff57c00),
  "orange800": Color(0xffef6c00),
  "orange900": Color(0xffe65100),
  "yellow100": Color(0xfffff9c4),
  "yellow200": Color(0xfffff59d),
  "yellow300": Color(0xfffff176),
  "yellow400": Color(0xffffee58),
  "yellow500": Color(0xffffeb3b),
  "yellow600": Color(0xfffdd835),
  "yellow700": Color(0xfffbc02d),
  "yellow800": Color(0xfff9a825),
  "yellow900": Color(0xfff57f17),
  "green100": Color(0xffc8e6c9),
  "green200": Color(0xffa5d6a7),
  "green300": Color(0xff81c784),
  "green400": Color(0xff66bb6a),
  "green500": Color(0xff4caf50),
  "green600": Color(0xff43a047),
  "green700": Color(0xff388e3c),
  "green800": Color(0xff2e7d32),
  "green900": Color(0xff1b5e20),
  "teal100": Color(0xffb2dfdb),
  "teal200": Color(0xff80cbc4),
  "teal300": Color(0xff4db6ac),
  "teal400": Color(0xff26a69a),
  "teal500": Color(0xff009688),
  "teal600": Color(0xff00897b),
  "teal700": Color(0xff00796b),
  "teal800": Color(0xff00695c),
  "teal900": Color(0xff004d40),
  "cyan100": Color(0xffb2ebf2),
  "cyan200": Color(0xff80deea),
  "cyan300": Color(0xff4dd0e1),
  "cyan400": Color(0xff26c6da),
  "cyan500": Color(0xff00bcd4),
  "cyan600": Color(0xff00acc1),
  "cyan700": Color(0xff0097a7),
  "cyan800": Color(0xff00838f),
  "cyan900": Color(0xff006064),
  "blue100": Color(0xffbbdefb),
  "blue200": Color(0xff90caf9),
  "blue300": Color(0xff64b5f6),
  "blue400": Color(0xff42a5f5),
  "blue500": Color(0xff2196f3),
  "blue600": Color(0xff1e88e5),
  "blue700": Color(0xff1976d2),
  "blue800": Color(0xff1565c0),
  "blue900": Color(0xff0d47a1),
  "blueGrey100": Color(0xffcfd8dc),
  "blueGrey200": Color(0xffb0bec5),
  "blueGrey300": Color(0xff90a4ae),
  "blueGrey400": Color(0xff78909c),
  "blueGrey500": Color(0xff607d8b),
  "blueGrey600": Color(0xff546e7a),
  "blueGrey700": Color(0xff455a64),
  "blueGrey800": Color(0xff37474f),
  "blueGrey900": Color(0xff263238),
  "purple100": Color(0xffe1bee7),
  "purple200": Color(0xffce93d8),
  "purple300": Color(0xffba68c8),
  "purple400": Color(0xffab47bc),
  "purple500": Color(0xff9c27b0),
  "purple600": Color(0xff8e24aa),
  "purple700": Color(0xff7b1fa2),
  "purple800": Color(0xff6a1b9a),
  "purple900": Color(0xff4a148c),
};

List<Map<String, dynamic>> getColorsMapAsList() {
  List<Map<String, dynamic>> materialColorsList = [];
  materialColorMap.forEach((key, value) {
    materialColorsList.add({"name": key, "color": value});
  });

  return materialColorsList;
}
