import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/TopTextButtonStack.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ErrorDialog.dart';

class ImportBackUpView extends StatefulWidget {
  @override
  _ImportBackUpViewState createState() => _ImportBackUpViewState();
}

class _ImportBackUpViewState extends State<ImportBackUpView> {
  String categoryDBPath = '';
  String transactionDBPath = '';
  bool _disableButton = true;

  void _enableButton() {
    if (categoryDBPath != '' && transactionDBPath != '') {
      setState(() {
        _disableButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              TopTextButtonStack(title: "Import Back Up"),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Import 'category.db' file.",
                    style: TextStyle(color: categoryDBPath != '' ? Theme.of(context).primaryColor : Colors.red),
                  ),
                  RaisedButton(
                      child: Text('Import'),
                      onPressed: () async {
                        File file;
                        try {
                          file = await FilePicker.getFile(type: FileType.any);
                        } on PlatformException catch (e) {
                          print("Unsupported operation" + e.toString());
                        }

                        if (file != null) {
                          if (file.path.contains('category')) {
                            setState(() {
                              categoryDBPath = file.path;
                            });
                            _enableButton();
                          } else {
                            errorMsgDialog(context, "Invalid file. Please import file named 'category.db'.");
                          }
                        }
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Import 'userTransaction.db' file.",
                    style: TextStyle(color: transactionDBPath != '' ? Theme.of(context).primaryColor : Colors.red),
                  ),
                  RaisedButton(
                      child: Text('Import'),
                      onPressed: () async {
                        File file;
                        try {
                          file = await FilePicker.getFile(type: FileType.any);
                        } on PlatformException catch (e) {
                          print("Unsupported operation" + e.toString());
                        }

                        if (file != null) {
                          if (file.path.contains('userTransaction')) {
                            setState(() {
                              transactionDBPath = file.path;
                            });
                            _enableButton();
                          } else {
                            errorMsgDialog(context, "Invalid file. Please import file named 'userTransaction.db'.");
                          }
                        }
                      }),
                ],
              ),
              RaisedButton(
                  child: Text("Confirm"),
                  onPressed: _disableButton
                      ? null
                      : () async {
                          await appProvider.importBackupCategory(categoryDBPath);
                          await appProvider.importBackupTransaction(transactionDBPath);

                          await appProvider.restartAppProviderService();

                          Navigator.pop(context);
                        }),
            ],
          ),
        ),
      ),
    );
  }
}
