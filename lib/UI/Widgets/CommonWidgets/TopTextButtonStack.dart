import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TopTextButtonStack extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode focusNode1;
  final FocusNode focusNode2;
  final String title;
  final Function method;

  TopTextButtonStack({@required this.title, this.focusNode, this.focusNode1, this.focusNode2, this.method});

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
              if (method != null) {
                method();
              }

              Navigator.pop(context);
            });
          },
        ),
      ),
    ]);
  }
}
