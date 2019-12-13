import 'package:flutter/material.dart';
import 'package:spending_tracker/UI/Widgets/SettingsWidgets/SettingsListTile.dart';

class SettingsView extends StatelessWidget {
  final List<Widget> settingsList = [AddCategory(), ReorgCategoryListTile()];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.all(8),
            child: Center(
              child: Text(
                "Settings",
                textScaleFactor: 1,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return settingsList[index];
            },
            childCount: settingsList.length,
          ),
        ),
      ],
    );
  }
}
