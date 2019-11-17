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
//color: greyCityLights,
//Text(" Intermediate", style: TextStyle(color: Colors.white))
// child: Column(
//           children: <Widget>[
//             Icon(
//               SpendingTrackerIcons.fuel,
//               size: 50,
//             ),
//             txData.desc == ""
//                 ? Text(
//                     txData.name,
//                     style: TextStyle(color: greyCityLights, fontWeight: FontWeight.bold, fontSize: 22),
//                   )
//                 : Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         txData.name,
//                         style: TextStyle(color: greyCityLights, fontWeight: FontWeight.bold, fontSize: 22),
//                       ),
//                       Text(
//                         txData.desc,
//                         style: TextStyle(color: greyCityLights, fontSize: 16),
//                       ),
//                     ],
//                   ),
//             Divider(
//               color: greyCityLights,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   DateFormat.Md().format(DateTime.fromMillisecondsSinceEpoch(txData.date, isUtc: true)),
//                   style: TextStyle(color: greyCityLights, fontWeight: FontWeight.bold, fontSize: 22),
//                 ),
//                 Text(
//                   txData.category,
//                   style: TextStyle(color: greyCityLights, fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 Text(
//                   txData.amount.toString(),
//                   style: TextStyle(color: greyCityLights, fontWeight: FontWeight.bold, fontSize: 25),
//                 ),
//               ],
//             ),
//           ],
//         ),

// decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: greySlightlyDarkBlue,
//           boxShadow: <BoxShadow>[
//             BoxShadow(color: Colors.black54, offset: Offset(1.1, 1.1), blurRadius: 10.0),
//           ],
//         ),

// ListTile(
//             contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//             leading: Tooltip(
//               message: txData.category,
//               child: Container(
//                 padding: EdgeInsets.only(right: 12.0),
//                 decoration: BoxDecoration(
//                   border: Border(
//                     right: BorderSide(width: 1.0, color: Colors.white24),
//                   ),
//                 ),
//                 child: Icon(categoryIconMap[txData.category.toLowerCase()]),
//               ),
//             ),
//             title: txData.desc == ""
//                 ? Text(
//                     txData.name,
//                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//                   )
//                 : Column(
//                     children: <Widget>[
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           txData.name,
//                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           txData.desc,
//                           style: TextStyle(color: greyCityLights, fontSize: 20),
//                         ),
//                       ),
//                     ],
//                   ),
//             subtitle: Text(
//               "\$${txData.amount}",
//               style: TextStyle(color: tealLessThanRobinsEgg, fontSize: 18),
//             ),
//             trailing: Icon(Icons.keyboard_arrow_right, color: greyCityLights, size: 30.0),
//           ),
