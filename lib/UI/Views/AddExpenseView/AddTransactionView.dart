import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/RaisedButtonWidget.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/TextfieldWidget.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ErrorDialog.dart';
import '../../../Core/ViewModels/AppProvider.dart';
import '../../Widgets/Dialog/AddTxDialogPickers.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  //Variables
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final amountController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode amountFocusNode = FocusNode();
  //String _errorMsg;
  DateTime _selectedDate;
  String _category = "None";
  bool _transactionAdded = false;

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
      _category = "None";
      _selectedDate = null;
      _transactionAdded = true;
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
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 28,
                    color: Theme.of(context).primaryColor,
                    tooltip: "Back",
                    onPressed: () async {
                      if (_transactionAdded) {
                        await appProvider.refreshTransactions();
                        unfocusTextFieldAndPop(context, nameFocusNode, amountFocusNode, descFocusNode);
                      } else {
                        unfocusTextFieldAndPop(context, nameFocusNode, amountFocusNode, descFocusNode);
                      }
                    },
                  ),
                  Text(
                    "Add",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    iconSize: 28,
                    color: Theme.of(context).primaryColor,
                    tooltip: "Add",
                    onPressed: () async {
                      Map<String, dynamic> validMap = checkValidFields(
                          name: nameController.text.trim(),
                          desc: descController.text.trim(),
                          amount: amountController.text.trim(),
                          category: _category,
                          date: _selectedDate);
                      if (validMap["valid"]) {
                        double amountDouble = double.parse(amountController.text.trim());
                        appProvider
                            .insertUserTransaction(
                                nameController.text.trim(),
                                double.parse(amountDouble.toStringAsFixed(2)),
                                descController.text.trim(),
                                _selectedDate,
                                _category)
                            .then((resp) {
                          _afterSubmit();
                        });
                      } else {
                        errorMsgDialog(context, validMap["error"]);
                      }
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
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

//floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// floatingActionButton: Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       FloatingActionButton.extended(
//         backgroundColor: Theme.of(context).primaryColor,
//         heroTag: "backButton",
//         icon: const Icon(Icons.arrow_back),
//         label: _transactionAdded ? Text("Done") : Text("Back"),
//         onPressed: () async {
//           if (_transactionAdded) {
//             await appProvider.refreshTransactions();
//             SchedulerBinding.instance.addPostFrameCallback((_) {
//               nameFocusNode.unfocus();
//               amountFocusNode.unfocus();
//               descFocusNode.unfocus();
//               Navigator.pop(context);
//             });
//           } else {
//             SchedulerBinding.instance.addPostFrameCallback((_) {
//               nameFocusNode.unfocus();
//               amountFocusNode.unfocus();
//               descFocusNode.unfocus();
//               Navigator.pop(context);
//             });
//           }
//         },
//       ),
//       FloatingActionButton.extended(
//         backgroundColor: Theme.of(context).primaryColor,
//         heroTag: "addButton",
//         icon: const Icon(Icons.add_circle_outline),
//         label: const Text("Add"),
//         onPressed: () {
//           Map<String, dynamic> validMap = _checkValidFields();
//           if (validMap["valid"]) {
//             double amountDouble = double.parse(amountController.text);
//             appProvider
//                 .insertUserTransaction(
//                     _trimText(nameController.text),
//                     double.parse(amountDouble.toStringAsFixed(2)),
//                     _trimText(descController.text),
//                     _selectedDate,
//                     _category)
//                 .then((resp) {
//               _afterSubmit();
//             });
//           } else {
//             errorMsgDialog(context, validMap["error"]);
//           }
//         },
//       ),
//     ],
//   ),
// ),

// TextField(
//   focusNode: nameFocusNode,
//   style: const TextStyle(color: Colors.green),
//   decoration: _textDecoration('Name', 'Enter transaction name', 0),
//   controller: nameController,
//   textCapitalization: TextCapitalization.words,
// ),
// TextField(
//   focusNode: descFocusNode,
//   style: const TextStyle(color: Colors.green),
//   decoration: _textDecoration('Description', '(Optional) Enter description', 1),
//   controller: descController,
//   textCapitalization: TextCapitalization.words,
// ),
// TextField(
//   focusNode: amountFocusNode,
//   keyboardType: TextInputType.number,
//   style: const TextStyle(color: Colors.green),
//   decoration: _textDecoration('Amount', 'Enter the amount (eg. 0.00)', 2),
//   controller: amountController,
// ),

//----------------------------------------------Widgets-----------------------------------------
///Returns an InputDecoration widget that styles the text input fields with their respective clear functions.
// InputDecoration _textDecoration(String label, String hintValue, int textFieldId) {
//   return InputDecoration(
//       labelText: label,
//       labelStyle: TextStyle(color: Theme.of(context).primaryColor),
//       hintText: hintValue,
//       enabledBorder: UnderlineInputBorder(
//         borderSide: BorderSide(color: Theme.of(context).primaryColor),
//       ),
//       focusedBorder: UnderlineInputBorder(
//         borderSide: BorderSide(color: Theme.of(context).primaryColor),
//       ),
//       suffixIcon: _textFieldIconButton(textFieldId));
// }

//----------------------------------------------Clear Functions-----------------------------------------

// IconButton _textFieldIconButton(int textFieldId) {
//   if (textFieldId == 0) {
//     return textFieldIconButton(textFieldId, nameFocusNode, nameController);
//   } else if (textFieldId == 1) {
//     return textFieldIconButton(textFieldId, descFocusNode, descController);
//   }
//   return textFieldIconButton(textFieldId, amountFocusNode, amountController);
// }
