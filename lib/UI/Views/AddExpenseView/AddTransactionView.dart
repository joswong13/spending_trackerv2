import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/TopTextButtonStack.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/RaisedButtonWidget.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/TextfieldWidget.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ErrorDialog.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/AddTxDialogPickers.dart';
import 'package:spending_tracker/Core/Services/Validators/TextFieldValidators.dart';

class TransactionScreen extends StatefulWidget {
  final String category;
  final DateTime date;

  TransactionScreen({this.date, this.category});

  @override
  _TransactionScreenState createState() => _TransactionScreenState(this.date, this.category);
}

class _TransactionScreenState extends State<TransactionScreen> {
  //Variables
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final amountController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode amountFocusNode = FocusNode();
  DateTime _selectedDate;
  String _category;
  bool _transactionAdded = false;

  _TransactionScreenState(DateTime date, String category) {
    this._selectedDate = date;
    if (category == null) {
      this._category = "none";
    } else {
      this._category = category;
    }
  }

//----------------------------------------------Functions-----------------------------------------
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    nameFocusNode.dispose();
    descFocusNode.dispose();
    amountFocusNode.dispose();

    super.dispose();
  }

  void _setCategoryState(String category) {
    setState(() {
      _category = category;
    });
  }

//----------------------------------------------On Submit Functions-----------------------------------------

  ///After submitting, clears and resets the form.
  void _afterSubmit() {
    textfieldFullClearUnfocus(focusNode: nameFocusNode, textFieldController: nameController);
    textfieldFullClearUnfocus(focusNode: amountFocusNode, textFieldController: amountController);
    textfieldFullClearUnfocus(focusNode: descFocusNode, textFieldController: descController);
    setState(() {
      _category = "none";
      _selectedDate = null;
      _transactionAdded = true;
    });
  }

  IconButton _addTransactionIconButton({Color color, String tooltip, Function insertMethod}) {
    return IconButton(
      icon: const Icon(Icons.add_circle_outline),
      iconSize: 28,
      color: color,
      tooltip: tooltip,
      onPressed: () async {
        insertMethod();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            child: Column(
              children: <Widget>[
                TopTextButtonStack(
                  title: "Add",
                  focusNode: nameFocusNode,
                  focusNode1: amountFocusNode,
                  focusNode2: descFocusNode,
                  method: appProvider.refreshTransactions,
                  runMethod: _transactionAdded,
                  widget: _addTransactionIconButton(
                    color: Theme.of(context).primaryColor,
                    tooltip: "Add",
                    insertMethod: () {
                      Map<String, dynamic> validMap = validateTransactionFields(
                          name: nameController.text.trim(),
                          desc: descController.text.trim(),
                          amount: amountController.text.trim(),
                          category: _category,
                          date: _selectedDate);
                      if (validMap["valid"]) {
                        appProvider
                            .insertUserTransaction(
                                nameController.text.trim(),
                                parseDoubleFromController(amountController.text),
                                descController.text.trim(),
                                _selectedDate,
                                _category)
                            .then((resp) {
                          onSubmitSnackbar(context, nameController.text.trim());
                          _afterSubmit();
                        });
                      } else {
                        errorMsgDialog(context, validMap["error"]);
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
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
      ),
    );
  }
}
