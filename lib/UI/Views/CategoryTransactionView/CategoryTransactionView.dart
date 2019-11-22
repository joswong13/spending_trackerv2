import 'package:spending_tracker/Core/Models/UserTransaction.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/CommonFunctions.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/RaisedButtonWidget.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:spending_tracker/UI/Widgets/MonthlyViewWidget/TransactionItemCard.dart';

class CategoryTransactionView extends StatelessWidget {
  final String _categoryType;
  final List<UserTransaction> _categoryList;

  ///The view of listing out all the category transactions given the category type, amount, and list of transactions.
  CategoryTransactionView(this._categoryList, this._categoryType);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 28,
                      color: Theme.of(context).primaryColor,
                      tooltip: "Back",
                      onPressed: () async {
                        appProvider.categoryType = "";
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        upperCaseFirstLetter(_categoryType),
                        textScaleFactor: 1,
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "\$" + appProvider.monthlyCategoryTotals[_categoryType].toStringAsFixed(2),
                        textScaleFactor: 1,
                        style:
                            TextStyle(fontSize: 28, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _categoryList.isEmpty
                ? emptyTransactionListAddButton(context, "Add transactions for " + _categoryType)
                : Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                      child: ListView.builder(
                        itemCount: _categoryList.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  DateFormat("MMM EEE d")
                                      .format(DateTime.fromMillisecondsSinceEpoch(_categoryList[index].date)),
                                  textScaleFactor: 1,
                                  style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                                ),
                                TransactionItemCard(txData: _categoryList[index]),
                              ],
                            ),
                          );
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
