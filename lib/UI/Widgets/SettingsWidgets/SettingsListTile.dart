import 'package:flutter/material.dart';
import 'package:spending_tracker/UI/Views/CategoryTransactionView/ReorganizeCategoryView.dart';
import 'package:spending_tracker/UI/Views/CreateCategoryView/CreateCategoryView.dart';

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
