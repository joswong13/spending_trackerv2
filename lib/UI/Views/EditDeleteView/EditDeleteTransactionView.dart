import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/RaisedButtonWidget.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/TextfieldWidget.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ErrorDialog.dart';
import '../../../Core/ViewModels/AppProvider.dart';
import '../../Widgets/Dialog/AddTxDialogPickers.dart';
import '../../Widgets/Dialog/DeleteDialog.dart';

class EditScreen extends StatefulWidget {
  final String name;
  final String desc;
  final double amount;
  final int date;
  final String category;
  final int id;
  final int uploaded;

  EditScreen(this.id, this.name, this.desc, this.amount, this.date, this.category, this.uploaded);

  @override
  _TransactionScreenState createState() => _TransactionScreenState(name, desc, amount, date, category);
}

class _TransactionScreenState extends State<EditScreen> {
  //Variables
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode amountFocusNode = FocusNode();
  DateTime _selectedDate;
  String _category = "None";

  _TransactionScreenState(String name, String desc, double amount, int date, String category) {
    nameController = TextEditingController(text: name);
    descController = TextEditingController(text: desc);
    amountController = TextEditingController(text: amount.toString());
    _selectedDate = DateTime.fromMillisecondsSinceEpoch(date, isUtc: true);
    _category = category;
  }

//----------------------------------------------Functions-----------------------------------------
  void _setCategoryState(String category) {
    setState(() {
      _category = category;
    });
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 28,
                    color: Theme.of(context).primaryColor,
                    tooltip: "Back",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Edit",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.delete),
                        iconSize: 28,
                        color: Theme.of(context).primaryColor,
                        tooltip: "Delete",
                        onPressed: () async {
                          bool deleteConfirmation = await deleteDialog(context);
                          if (deleteConfirmation) {
                            appProvider.deleteUserTransaction(widget.id).then((resp) async {
                              if (resp == 1) {
                                await appProvider.refreshTransactions();
                                Navigator.pop(context);
                              }
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.check_circle_outline),
                        iconSize: 28,
                        color: Theme.of(context).primaryColor,
                        tooltip: "Confirm",
                        onPressed: () {
                          Map<String, dynamic> validMap = checkValidFields(
                              name: nameController.text,
                              amount: amountController.text,
                              category: _category,
                              date: _selectedDate);
                          if (validMap["valid"]) {
                            appProvider
                                .updateUserTransaction(
                                    widget.id,
                                    nameController.text.trim(),
                                    double.parse(amountController.text),
                                    descController.text.trim(),
                                    _selectedDate,
                                    _category,
                                    widget.uploaded)
                                .then((resp) async {
                              if (resp == 1) {
                                await appProvider.refreshTransactions();
                                Navigator.pop(context);
                              }
                            });
                          } else {
                            errorMsgDialog(context, validMap["error"]);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    transactionTextfield(Theme.of(context).primaryColor, nameFocusNode, nameController, 'Name',
                        'Enter transaction name'),
                    transactionTextfield(Theme.of(context).primaryColor, descFocusNode, descController, 'Description',
                        '(Optional) Enter description'),
                    transactionTextfield(Theme.of(context).primaryColor, amountFocusNode, amountController, 'Amount',
                        'Enter the amount (eg. 0.00)'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Category:',
                          textScaleFactor: 1,
                          style: TextStyle(fontSize: 18),
                        ),
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: raisedButtonTextSize14(_category),
                          shape: roundedRect30,
                          onPressed: () async {
                            if (appProvider.userCategoryList.length == 0) {
                              await errorEmptyCategoryDialog(context);
                            } else {
                              categoryDialog(context, appProvider.userCategoryList, _category).then((String resp) {
                                _setCategoryState(resp);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _selectedDate == null ? 'No Date Chosen' : DateFormat.yMd().format(_selectedDate),
                          textScaleFactor: 1,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: raisedButtonTextSize14("Choose Date"),
                          shape: roundedRect30,
                          onPressed: () {
                            presentDatePicker(context, _selectedDate).then((DateTime resp) {
                              setState(() {
                                _selectedDate = resp;
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             FloatingActionButton.extended(
//               backgroundColor: Theme.of(context).primaryColor,
//               heroTag: "backButton",
//               icon: const Icon(Icons.arrow_back),
//               label: const Text("Back"),
//               onPressed: () async {
//                 Navigator.pop(context);
//               },
//             ),
//             FloatingActionButton.extended(
//               backgroundColor: Theme.of(context).primaryColor,
//               heroTag: "deleteButton",
//               icon: const Icon(Icons.delete),
//               label: const Text("Delete"),
//               onPressed: () async {
//                 bool deleteConfirmation = await deleteDialog(context);
//                 if (deleteConfirmation) {
//                   appProvider.deleteUserTransaction(widget.id).then((resp) async {
//                     if (resp == 1) {
//                       await appProvider.refreshTransactions();
//                       Navigator.pop(context);
//                     }
//                   });
//                 }
//               },
//             ),
//             FloatingActionButton.extended(
//               backgroundColor: Theme.of(context).primaryColor,
//               heroTag: "editButton",
//               icon: const Icon(Icons.edit),
//               label: const Text("Edit"),
//               onPressed: () {
//                 Map<String, dynamic> validMap = checkValidFields(
//                     name: nameController.text, amount: amountController.text, category: _category, date: _selectedDate);
//                 if (validMap["valid"]) {
//                   appProvider
//                       .updateUserTransaction(
//                           widget.id,
//                           _trimText(nameController.text),
//                           double.parse(amountController.text),
//                           _trimText(descController.text),
//                           _selectedDate,
//                           _category,
//                           widget.uploaded)
//                       .then((resp) async {
//                     if (resp == 1) {
//                       await appProvider.refreshTransactions();
//                       Navigator.pop(context);
//                     }
//                   });
//                 } else {
//                   errorMsgDialog(context, validMap["error"]);
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
