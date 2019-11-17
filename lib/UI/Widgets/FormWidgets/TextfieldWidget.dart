import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

/// Removes any spaces inside the amount textfield
double parseDoubleFromController(String amountText) {
  String result = amountText.replaceAll(RegExp(r"\s+\b|\b\s"), "");
  return double.tryParse(result);
}

///Creates a textfield given the parameters.
TextField transactionTextfield(
    Color primary, FocusNode focusNode, TextEditingController controller, String label, String hint, bool isNum) {
  TextInputType keyboard;
  List<TextInputFormatter> formatters;
  if (isNum) {
    keyboard = TextInputType.numberWithOptions(decimal: true);
    formatters = [DecimalTextInputFormatter(decimalRange: 2)];
  } else {
    keyboard = TextInputType.text;
    formatters = [];
  }
  return TextField(
    focusNode: focusNode,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: primary),
      hintText: hint,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primary),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primary),
      ),
      suffixIcon: _textFieldIconButton(focusNode, controller),
    ),
    controller: controller,
    textCapitalization: TextCapitalization.words,
    keyboardType: keyboard,
    inputFormatters: formatters,
  );
}

void _textfieldClearSuffixIcon({FocusNode focusNode, TextEditingController textfieldController}) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    focusNode.unfocus();
    textfieldController.clear();
    focusNode.requestFocus();
  });
}

IconButton _textFieldIconButton(FocusNode focusNode, TextEditingController textController) {
  return IconButton(
    icon: Icon(Icons.clear),
    onPressed: () {
      _textfieldClearSuffixIcon(focusNode: focusNode, textfieldController: textController);
    },
  );
}

///Given the context and between 1 to 3 focus nodes, this method will unfocus and pop context.
void unfocusTextFieldAndPop(BuildContext context, FocusNode focusNode1, [FocusNode focusNode2, FocusNode focusNode3]) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    if (focusNode1 != null) {
      focusNode1.unfocus();
    }
    if (focusNode2 != null) {
      focusNode2.unfocus();
    }
    if (focusNode3 != null) {
      focusNode3.unfocus();
    }
    Navigator.pop(context);
  });
}

///Given a FocusNode and the TextFieldController, this will unfocus and clear the text field.
void textfieldFullClearUnfocus({FocusNode focusNode, TextEditingController textFieldController}) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    focusNode.unfocus();
    textFieldController.clear();
  });
}

//--------------------------------------------------------------------------------------------------------------------------------------
// Used for making sure there ar eonly two decimal places in a text field
class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange}) : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") && value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}

// return Scaffold(
//   appBar: AppBar(
//     title: Text("Flutter"),
//   ),
//   body: Form(
//     child: ListView(
//       children: <Widget>[
//         TextFormField(
//           inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
//           keyboardType: TextInputType.numberWithOptions(decimal: true),
//         )
//       ],
//     ),
//   ),
// );

// class DecimalTextInputFormatter extends TextInputFormatter {
//   DecimalTextInputFormatter({int decimalRange, bool activatedNegativeValues})
//       : assert(decimalRange == null || decimalRange >= 0, 'DecimalTextInputFormatter declaretion error') {
//     String dp = (decimalRange != null && decimalRange > 0) ? "([.][0-9]{0,$decimalRange}){0,1}" : "";
//     String num = "[0-9]*$dp";

//     if (activatedNegativeValues) {
//       _exp = new RegExp("^((((-){0,1})|((-){0,1}[0-9]$num))){0,1}\$");
//     } else {
//       _exp = new RegExp("^($num){0,1}\$");
//     }
//   }

//   RegExp _exp;

//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     if (_exp.hasMatch(newValue.text)) {
//       return newValue;
//     }
//     return oldValue;
//   }
// }
