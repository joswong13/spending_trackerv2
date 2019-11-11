import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Views/EditCategoryView/EditCategoryView.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/CommonFunctions.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/DeleteDialog.dart';

class CategoryListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Expanded(
      child: Container(
        margin: EdgeInsets.fromLTRB(40, 5, 40, 0),
        child: ListView.builder(
          itemCount: appProvider.userCategoryList.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Card(
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
                      child: Icon(icons[appProvider.userCategoryList[index].icon]),
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
                        upperCaseFirstLetter(appProvider.userCategoryList[index].name),
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
                                  return EditCategoryView(appProvider.userCategoryList[index]);
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
                                await appProvider
                                    .deleteAllUserTransactionInCategory(appProvider.userCategoryList[index].name);

                                await appProvider
                                    .deleteUserCategory(appProvider.userCategoryList[index].id)
                                    .then((resp) {
                                  appProvider.refreshTransactions();
                                });
                              }
                            });
                          },
                        ),
                      ),
                    ),

                    //         // RaisedButton.icon(
                    //         //   icon: Icon(Icons.delete),
                    //         //   color: Colors.red,
                    //         //   //child: Text("Delete"),
                    //         //   onPressed: () {
                    //         //     deleteCategoryDialog(context).then((bool confirmation) async {
                    //         //       if (confirmation) {
                    //         //         await appProvider
                    //         //             .deleteAllUserTransactionInCategory(appProvider.userCategoryList[index].name);

                    //         //         await appProvider
                    //         //             .deleteUserCategory(appProvider.userCategoryList[index].id)
                    //         //             .then((resp) {
                    //         //           appProvider.refreshTransactions();
                    //         //         });
                    //         //       }
                    //         //     });
                    //         //   },
                    //         // ),
                    //         ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
