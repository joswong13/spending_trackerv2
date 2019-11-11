import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';
import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/CommonFunctions.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/RaisedButtonWidget.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/TextfieldWidget.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/TopTextButtonStack.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/CategoryIconDialog.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ColorDialog.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ErrorDialog.dart';

class EditCategoryView extends StatefulWidget {
  // final String categoryName;
  // final String iconName;
  // final String colorOne;
  // final String colorTwo;
  // final int id;
  final UserCategory userCategory;
  EditCategoryView(this.userCategory);

  @override
  _EditCategoryViewState createState() => _EditCategoryViewState(userCategory);
}

class _EditCategoryViewState extends State<EditCategoryView> {
  String _name = "";
  String _categoryIcon = "Choose Icon";
  String _colorOne = 'greyVeryDarkBlue';
  String _colorTwo = 'greyVeryDarkBlue';
  int _id;

  _EditCategoryViewState(UserCategory userCategory) {
    _name = userCategory.name;
    _categoryIcon = userCategory.icon;
    _colorOne = userCategory.colorOne;
    _colorTwo = userCategory.colorTwo;
    _id = userCategory.id;
  }

  void _setCategoryIcon(String iconName) {
    setState(() {
      _categoryIcon = iconName;
    });
  }

  void _resetContainerColor() {
    setState(() {
      _colorOne = 'greyVeryDarkBlue';
      _colorTwo = 'greyVeryDarkBlue';
    });
  }

  Map<String, dynamic> _validateCreateCategory() {
    Map<String, dynamic> validMap;
    if (_categoryIcon == "Choose Icon") {
      return validMap = {"valid": false, "error": "Error: Need category icon"};
    }
    return validMap = {"valid": true};
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Column(
            children: <Widget>[
              TopTextButtonStack(title: "Category Management"),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      materialColorMap[_colorOne],
                      materialColorMap[_colorTwo],
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      upperCaseFirstLetter(_name),
                      textScaleFactor: 1,
                      style: TextStyle(fontSize: 27),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            shape: roundedRect30,
                            child: raisedButtonTextSize14("Color 1"),
                            onPressed: () {
                              colorDialog(context).then((resp) {
                                setState(() {
                                  _colorOne = resp;
                                });
                              });
                            },
                          ),
                          RaisedButton(
                            shape: roundedRect30,
                            child: raisedButtonTextSize14("Color 2"),
                            onPressed: () {
                              colorDialog(context).then((resp) {
                                setState(() {
                                  _colorTwo = resp;
                                });
                              });
                            },
                          ),
                          RaisedButton(
                            shape: roundedRect30,
                            child: raisedButtonTextSize14("Reset"),
                            onPressed: () {
                              _resetContainerColor();
                            },
                          ),
                        ],
                      ),
                    ),
                    _categoryIcon == "Choose Icon"
                        ? RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child: raisedButtonTextSize14(_categoryIcon),
                            shape: roundedRect30,
                            onPressed: () {
                              categoryIconDialog(context).then((String resp) {
                                if (resp != "Choose Icon") {
                                  _setCategoryIcon(resp);
                                }
                              });
                            },
                          )
                        : RaisedButton.icon(
                            icon: Icon(
                              icons[_categoryIcon],
                              color: Colors.black,
                            ),
                            color: Theme.of(context).primaryColor,
                            label: raisedButtonTextSize14(_categoryIcon),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              categoryIconDialog(context).then((String resp) {
                                _setCategoryIcon(resp);
                              });
                            },
                          ),
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                shape: roundedRect30,
                child: raisedButtonTextSize14("Save"),
                onPressed: () async {
                  Map<String, dynamic> validateMap = _validateCreateCategory();
                  if (validateMap["valid"]) {
                    await appProvider.updateUserCategory(_id, _name, _colorOne, _colorTwo, _categoryIcon);
                    await appProvider.refreshUserCategoryList();

                    Navigator.pop(context);
                  } else {
                    errorMsgDialog(context, validateMap["error"]);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
