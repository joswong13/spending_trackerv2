import 'package:flutter/material.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';
import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/CommonFunctions.dart';

enum Category { GAS, FOOD, GROCCERIES, RECURRING, SHOPPING, ENTERTAINMENT, TRANSPORTATION, MISC }

Future<DateTime> presentDatePicker(BuildContext context, DateTime selectedDate) async {
  DateTime datePicked = await showDatePicker(
    context: context,
    initialDate: selectedDate == null ? DateTime.now() : selectedDate,
    firstDate: DateTime(2018),
    lastDate: DateTime.now(),
  );
  if (datePicked == null) {
    return selectedDate;
  } else {
    return DateTime.utc(datePicked.year, datePicked.month, datePicked.day);
  }
}

Future<String> categoryDialog(BuildContext context, List<UserCategory> categoriesList, String currentCategory) async {
  String category = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: Column(
              children: <Widget>[
                const Text('Select Category'),
                Divider(
                  color: Colors.white70,
                ),
              ],
            ),
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView(
                  children: categoriesList.map((category) {
                    return SimpleDialogOption(
                      child: ListTile(
                        leading: Icon(icons[category.icon]),
                        title: Text(upperCaseFirstLetter(category.name)),
                      ),
                      onPressed: () {
                        Navigator.pop(context, category.name);
                      },
                    );
                  }).toList(),
                ),
              )
            ]);
      });

  if (category == null) {
    category = currentCategory;
  }
  return category;
}
