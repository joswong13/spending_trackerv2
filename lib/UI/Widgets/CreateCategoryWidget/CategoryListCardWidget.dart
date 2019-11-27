import 'package:flutter/material.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';
import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/UI/Views/EditCategoryView/EditCategoryView.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/CommonFunctions.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/DeleteDialog.dart';

class CategoryListCardWidget extends StatelessWidget {
  final UserCategory uc;
  final Function func;

  /// Given a user category and a function to run on delete, creates a card to display in the CreateCategoryListView.
  CategoryListCardWidget({this.uc, this.func});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(40, 5, 40, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(icons[uc.icon]),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1.0, color: Colors.white24),
                ),
              ),
              padding: EdgeInsets.only(left: 12.0),
              child: Text(
                upperCaseFirstLetter(uc.name),
                textScaleFactor: 1,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) {
                          return EditCategoryView(uc);
                        }),
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.all(10),
                child: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    deleteCategoryDialog(context).then((bool confirmation) async {
                      if (confirmation) {
                        func();
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
