import 'package:spending_tracker/Core/Models/UserTransaction.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/CommonFunctions.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/RaisedButtonWidget.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        child: Center(
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
                          "\$" + appProvider.monthlyCategoryTotals[_categoryType].toString(),
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 28, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
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
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) => const Divider(
                            color: Colors.white70,
                          ),
                          itemCount: _categoryList.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return TransactionItemCard(txData: _categoryList[index]);
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
// RaisedButton.icon(
//     elevation: 8,
//     shape: roundedRect30,
//     icon: Icon(
//       Icons.add_circle_outline,
//       color: Colors.black,
//     ),
//     label: Text(
//       "Add transactions for " + _categoryType,
//       textScaleFactor: 1,
//       style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500),
//     ),
//     onPressed: () {},
//   )
