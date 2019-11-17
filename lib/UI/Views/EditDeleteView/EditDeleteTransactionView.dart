import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/Services/Validators/TextFieldValidators.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/TopTextButtonStack.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/RaisedButtonWidget.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/TextfieldWidget.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ErrorDialog.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/AddTxDialogPickers.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/DeleteDialog.dart';

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
    amountController = TextEditingController(text: amount.toStringAsFixed(2));
    _selectedDate = DateTime.fromMillisecondsSinceEpoch(date, isUtc: true);
    _category = category;
  }

//----------------------------------------------Functions-----------------------------------------
  void _setCategoryState(String category) {
    setState(() {
      _category = category;
    });
  }

  Row _confirmAndDeleteIconRow({Color color, Function deleteMethod, Function confirmMethod}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.delete),
          iconSize: 28,
          color: color,
          tooltip: "Delete",
          onPressed: () async {
            deleteMethod();
          },
        ),
        IconButton(
          icon: const Icon(Icons.check_circle_outline),
          iconSize: 28,
          color: color,
          tooltip: "Confirm",
          onPressed: () async {
            confirmMethod();
          },
        ),
      ],
    );
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
              TopTextButtonStack(
                title: "Edit",
                focusNode: nameFocusNode,
                focusNode1: amountFocusNode,
                focusNode2: descFocusNode,
                widget: _confirmAndDeleteIconRow(
                    color: Theme.of(context).primaryColor,
                    deleteMethod: () async {
                      bool deleteConfirmation = await deleteDialog(context);
                      if (deleteConfirmation) {
                        appProvider.deleteUserTransaction(widget.id).then((resp) async {
                          if (resp == 1) {
                            Navigator.pop(context);
                          }
                        });
                      }
                    },
                    confirmMethod: () {
                      Map<String, dynamic> validMap = validateTransactionFields(
                          name: nameController.text.trim(),
                          amount: amountController.text.trim(),
                          desc: descController.text.trim(),
                          category: _category,
                          date: _selectedDate);
                      if (validMap["valid"]) {
                        appProvider
                            .updateUserTransaction(
                                widget.id,
                                nameController.text.trim(),
                                parseDoubleFromController(amountController.text),
                                descController.text.trim(),
                                _selectedDate,
                                _category,
                                widget.uploaded)
                            .then((resp) async {
                          if (resp == 1) {
                            Navigator.pop(context);
                          }
                        });
                      } else {
                        errorMsgDialog(context, validMap["error"]);
                      }
                    }),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    transactionTextfield(Theme.of(context).primaryColor, nameFocusNode, nameController, 'Name',
                        'Enter transaction name', false),
                    transactionTextfield(Theme.of(context).primaryColor, descFocusNode, descController, 'Description',
                        '(Optional) Enter description', false),
                    transactionTextfield(Theme.of(context).primaryColor, amountFocusNode, amountController, 'Amount',
                        'Enter the amount (eg. 0.00)', true),
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
