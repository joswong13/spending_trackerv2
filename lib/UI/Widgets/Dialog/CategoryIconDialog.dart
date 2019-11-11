import 'package:flutter/material.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';

Future<String> categoryIconDialog(BuildContext context) async {
  String categoryIcon = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Column(
            children: <Widget>[
              const Text('Select Category Icon'),
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
                  children: getIconMapAsList().map((eachIcon) {
                    return SimpleDialogOption(
                      child: Icon(eachIcon["icon"]),
                      onPressed: () {
                        Navigator.pop(context, eachIcon["name"]);
                      },
                    );
                  }).toList()),
            ),
          ],
        );
      });

  if (categoryIcon == null) {
    categoryIcon = "Choose Icon";
  }

  return categoryIcon;
}
