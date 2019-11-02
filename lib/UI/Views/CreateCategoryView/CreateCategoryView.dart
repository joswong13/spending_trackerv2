import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ConfirmationAlertDialog.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/RaisedButtonWidget.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/TextfieldWidget.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Views/CreateCategoryView/CreateCategoriesListView.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/TopTextButtonStack.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/CategoryIconDialog.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ColorDialog.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ErrorDialog.dart';

class CreateCategoryView extends StatefulWidget {
  @override
  _CreateCategoryViewState createState() => _CreateCategoryViewState();
}

class _CreateCategoryViewState extends State<CreateCategoryView> {
  final nameController = TextEditingController();
  final String confirmDialog =
      "Warning: This category name cannot be changed. Please confirm the following category name: ";
  String _categoryIcon = "Choose Icon";
  FocusNode focusNode = FocusNode();
  String _colorOne = 'greyVeryDarkBlue';
  String _colorTwo = 'greyVeryDarkBlue';

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
    if (nameController.text == "") {
      return validMap = {"valid": false, "error": "Error: Category name cannot be empty"};
    }
    if (_categoryIcon == "Choose Icon") {
      return validMap = {"valid": false, "error": "Error: Need category icon"};
    }
    return validMap = {"valid": true};
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
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
              TopTextButtonStack(title: "Category Management", focusNode: focusNode),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      colorsMap[_colorOne],
                      colorsMap[_colorTwo],
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    transactionTextfield(
                        Theme.of(context).primaryColor, focusNode, nameController, "Category Name", "Eg. Food"),
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
                child: raisedButtonTextSize14("Add Category"),
                onPressed: () async {
                  Map<String, dynamic> validateMap = _validateCreateCategory();
                  if (validateMap["valid"]) {
                    bool confirmation = await confirmationDialog(context, confirmDialog + nameController.text.trim());

                    if (confirmation) {
                      bool ifExists = await appProvider.categoryExists(nameController.text.trim());
                      print(ifExists);
                      if (!ifExists) {
                        await appProvider.addUserCategory(
                            nameController.text.trim(), _categoryIcon, _colorOne, _colorTwo);
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          focusNode.unfocus();
                          nameController.clear();
                          _setCategoryIcon("Choose Icon");
                          _resetContainerColor();
                        });
                      } else {
                        errorMsgDialog(context, "Category name already exists.");
                      }
                    }
                  } else {
                    errorMsgDialog(context, validateMap["error"]);
                  }
                },
              ),
              Divider(
                height: 0,
              ),
              CategoryListView()
            ],
          ),
        ),
      ),
    );
  }
}
