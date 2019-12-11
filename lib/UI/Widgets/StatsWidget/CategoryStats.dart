import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spending_tracker/Core/Constants/ColorPalette.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';
import 'package:spending_tracker/Core/Models/Stat.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/CommonFunctions.dart';

class CategoryStat extends StatelessWidget {
  final StatCategory _statCategory;

  CategoryStat(this._statCategory);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: darkGrey,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icons[_statCategory.icon]),
          AutoSizeText(
            upperCaseFirstLetter(_statCategory.category),
            style: TextStyle(fontSize: 24),
            maxLines: 1,
          ),
          AutoSizeText(
            "\$" + _statCategory.total.toStringAsFixed(2),
            style: TextStyle(fontSize: 24),
            maxLines: 1,
          ),
          AutoSizeText(
            _statCategory.numberOfTransactions.toString() + " Transaction(s)",
            style: TextStyle(fontSize: 20),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
