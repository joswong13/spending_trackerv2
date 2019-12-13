import 'package:flutter/material.dart';
import 'package:spending_tracker/UI/Views/CreateCategoryView/CreateCategoryView.dart';

Future<void> errorMsgDialog(BuildContext context, String errorMsg) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            errorMsg,
            textScaleFactor: 1,
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

Future<void> errorEmptyCategoryDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text("Please add Categories before adding transactions."),
          actions: <Widget>[
            FlatButton(
              child: const Text('Add Category'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return CreateCategoryView();
                  }),
                );
              },
            ),
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
