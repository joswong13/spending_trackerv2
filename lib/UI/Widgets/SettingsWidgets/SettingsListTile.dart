import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Views/CategoryTransactionView/ReorganizeCategoryView.dart';
import 'package:spending_tracker/UI/Views/CreateCategoryView/CreateCategoryView.dart';
import 'package:spending_tracker/UI/Views/ImportBackUpView/ImportBackUpView.dart';

class AddCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.settings),
      title: Text(
        "Category Management",
        textScaleFactor: 1,
      ),
      subtitle: Text("Add, edit, and delete categories."),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return CreateCategoryView();
          }),
        );
      },
    );
  }
}

class ReorgCategoryListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.swap_vert),
      title: Text(
        "Re-order Categories",
        textScaleFactor: 1,
      ),
      subtitle: Text("Customize category order."),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return ReorganizeCategoryView();
          }),
        );
      },
    );
  }
}

class AboutSpendingTrackerListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    final List<Widget> aboutBoxChildren = <Widget>[
      SizedBox(height: 24),
      RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                style: textStyle,
                text:
                    'Spending Tracker is an app to help people keep track of what they are spending on by sorting each expense into their corresponding categories. The code can be found at '),
            TextSpan(
                style: textStyle.copyWith(color: Theme.of(context).accentColor),
                text: 'https://github.com/joswong13/spending_trackerv2'),
            TextSpan(style: textStyle, text: '.'),
          ],
        ),
      ),
    ];

    return AboutListTile(
        icon: Icon(Icons.info),
        applicationName: "Spending Tracker",
        applicationVersion: "January 11 2020",
        applicationLegalese: "Built by Joseph Wong",
        aboutBoxChildren: aboutBoxChildren);
  }
}

class ExportBackUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return ListTile(
      leading: Icon(Icons.swap_vert),
      title: Text(
        "Export Back Up",
        textScaleFactor: 1,
      ),
      subtitle: Text("Export backup for Android"),
      onTap: () async {
        List<String> pathList = [];

        String transactionPath = await appProvider.exportBackupTransaction();
        String categoryPath = await appProvider.exportBackupCategory();

        pathList.add(transactionPath);
        pathList.add(categoryPath);
        ShareExtend.shareMultiple(pathList, 'file');
      },
    );
  }
}

class ImportBackUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.swap_vert),
      title: Text(
        "Import Back Up",
        textScaleFactor: 1,
      ),
      subtitle: Text("Import backup for Android"),
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return ImportBackUpView();
          }),
        );
      },
    );
  }
}
