import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Widgets/MonthlyViewWidget/EmptyTransactionListSliver.dart';
import 'package:spending_tracker/UI/Widgets/MonthlyViewWidget/TransactionItems.dart';
import '../../Widgets/MonthlyViewWidget/HeaderDelegate.dart';
import '../../Widgets/MonthlyViewWidget/CategoryHorizontalScrollBox.dart';

class MonthlyViewSliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return appProvider.busy
        ? Center(
            child: CircularProgressIndicator(),
          )
        : CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: CategoryHorizontalScrollBox(),
              ),
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: HeaderDelegate(minExtent: 44, maxExtent: 100),
              ),
              appProvider.txList.length == 0
                  ? SliverList(
                      delegate: SliverChildListDelegate([EmptyTransactionListSliver()]),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate(
                        appProvider.txList.map((eachTX) {
                          return TransactionItems(transaction: eachTX);
                        }).toList(),
                      ),
                    ),
            ],
          );
  }
}
