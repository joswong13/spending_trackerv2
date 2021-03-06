import 'package:flutter/material.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';

Future<String> colorDialog(BuildContext context) async {
  String color = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Column(
            children: <Widget>[
              const Text('Select Color'),
              Divider(
                color: Colors.white70,
              ),
            ],
          ),
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.7,
              child: GridView.count(
                crossAxisCount: 5,
                children:
                    //getColorsMapAsList().map((eachColor)
                    getColorsMapAsList().map((eachColor) {
                  return InkWell(
                    child: Container(
                      margin: EdgeInsets.all(2),
                      color: eachColor["color"],
                    ),
                    onTap: () {
                      Navigator.pop(context, eachColor["name"]);
                    },
                  );
                }).toList(),
              ),
            ),
            FlatButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: primaryGreen),
              ),
              onPressed: () {
                Navigator.pop(context, null);
              },
            ),
          ],
        );
      });

  if (color == null) {
    color = "blueGrey900";
  }
  return color;
}
