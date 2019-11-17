import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TopTextButtonStack extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode focusNode1;
  final FocusNode focusNode2;
  final String title;
  final Function method;
  final bool changed;
  final Widget widget;

  /// Returns a widget with a [title] in the middle, a back button with Navigator.pop(context) on the center left alignment, and a user widget on the center right alignment.
  /// The [title] sets the title text at the centre of widget. This widget can accept up to three focus nodes to unfocus when you press the back button.
  /// The [method] accepts a method to be called when clicking the back button other than poppping context and unfocusing FocusNodes.
  /// Set [changed] to true to run method when clicking back button. Accepts a [widget] for the top right alignment such as an icon button.
  ///
  /// ```
  /// TopTextButtonStack(
  ///   title: "Add",
  ///   focusNode: nameFocusNode,
  ///   focusNode1: amountFocusNode,
  ///   focusNode2: descFocusNode,
  ///   method: appProvider.refreshTransactions,
  ///   changed: _transactionAdded,
  ///   widget: addTransactionIconButton(
  ///       color: Theme.of(context).primaryColor,
  ///       tooltip: "Add",
  ///       insertMethod: () {
  ///          double amountDouble = double.parse(amountController.text.trim());
  ///          appProvider
  ///               .insertUserTransaction(
  ///                     nameController.text.trim(),
  ///                     double.parse(amountDouble.toStringAsFixed(2)),
  ///                     descController.text.trim(),
  ///                     _selectedDate,
  ///                     _category)
  ///                             .then((resp) {
  ///                                 _afterSubmit();
  ///                             });
  ///      }),
  /// )
  ///```
  TopTextButtonStack(
      {@required this.title, this.focusNode, this.focusNode1, this.focusNode2, this.method, this.changed, this.widget});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Align(
        alignment: Alignment.center,
        child: Text(
          title,
          textScaleFactor: 1,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 28,
          color: Theme.of(context).primaryColor,
          tooltip: "Back",
          onPressed: () async {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              if (focusNode != null) {
                focusNode.unfocus();
              }
              if (focusNode1 != null) {
                focusNode1.unfocus();
              }
              if (focusNode2 != null) {
                focusNode2.unfocus();
              }
              if (method != null && changed) {
                method();
              }

              Navigator.pop(context);
            });
          },
        ),
      ),
      if (widget != null)
        Align(
          alignment: Alignment.centerRight,
          child: widget,
        )
    ]);
  }
}
