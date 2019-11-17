import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/DeleteDialog.dart';
import '../../../Core/Models/UserTransaction.dart';
import '../../Views/EditDeleteView/EditDeleteTransactionView.dart';

class TransactionItemCard extends StatelessWidget {
  final UserTransaction txData;

  /// Initialize constructor with UserTransaction object
  TransactionItemCard({this.txData});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        appProvider.deleteUserTransaction(txData.id).then((resp) async {
          if (resp == 1) {
            await appProvider.refreshTransactions();
          }
        });
      },
      confirmDismiss: (DismissDirection direction) async {
        final dismissBool = await deleteDialog(context);
        return dismissBool;
      },
      child: InkWell(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              return EditScreen(
                  txData.id, txData.name, txData.desc, txData.amount, txData.date, txData.category, txData.uploaded);
            }),
          );
        },
        child: Row(
          children: <Widget>[
            Tooltip(
              message: txData.category,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  icons[appProvider.userCategoryMap[txData.category]],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1.0, color: Colors.white24),
                ),
              ),
              padding: EdgeInsets.only(left: 12.0),
              child: txData.desc == ""
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          txData.name,
                          style: TextStyle(fontSize: 22),
                        ),
                        Text(
                          "\$${txData.amount.toStringAsFixed(2)}",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          txData.name,
                          style: TextStyle(fontSize: 22),
                        ),
                        Text(
                          txData.desc,
                          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.60), fontSize: 20),
                        ),
                        Text(
                          "\$${txData.amount.toStringAsFixed(2)}",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
                        ),
                      ],
                    ),
            ),
            Expanded(
              child: Align(alignment: Alignment.centerRight, child: Icon(Icons.keyboard_arrow_right, size: 30.0)),
            )
          ],
        ),
      ),
    );
  }
}
