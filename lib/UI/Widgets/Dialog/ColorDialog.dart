import 'package:flutter/material.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';

Future<String> colorDialog(BuildContext context) async {
  String category = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Column(
            children: <Widget>[
              const Text('Select Color'),
              Divider(
                color: greyCityLights,
              ),
            ],
          ),
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.7,
              child: GridView.count(
                crossAxisCount: 5,
                children: getColorsMapAsList().map((eachColor) {
                  return SimpleDialogOption(
                    child: Container(
                      color: eachColor["color"],
                    ),
                    onPressed: () {
                      Navigator.pop(context, eachColor["name"]);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        );
      });

  if (category == null) {
    category = "Choose Icon";
  }

  return category;
}
