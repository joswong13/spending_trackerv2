import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spending_tracker/Core/Constants/ErrorCode.dart';

///Creates a textfield given the parameters.
TextField transactionTextfield(
    Color primary, FocusNode focusNode, TextEditingController controller, String label, String hint) {
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

///Checks if the required fields are filled out.
Map<String, dynamic> checkValidFields({String name, String desc, String amount, String category, DateTime date}) {
  double _tempAmount;

  //TODO: add more amount checks
  try {
    _tempAmount = double.parse(amount);
  } catch (e) {
    return {"valid": false, "error": ERR_TX_AMOUNT_PARSE_ERROR};
  }
  if (name == "") {
    return {"valid": false, "error": ERR_TX_NAME_EMPTY};
  } else if (name.length > 15) {
    return {"valid": false, "error": ERR_TX_NAME_TOO_LONG};
  } else if (desc.length > 15) {
    return {"valid": false, "error": ERR_TX_DESC_TOO_LONG};
  } else if (_tempAmount <= 0.00) {
    return {"valid": false, "error": ERR_TX_AMOUNT_DOUBLE_ERROR};
  } else if (category == "None") {
    return {"valid": false, "error": ERR_TX_CAT_NULL};
  } else if (date == null) {
    return {"valid": false, "error": ERR_TX_DATE_NULL};
  }
  return {"valid": true};
}

///Given a FocusNode and the TextFieldController, this will unfocus and clear the text field.
void textfieldFullClearUnfocus({FocusNode focusNode, TextEditingController textFieldController}) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    focusNode.unfocus();
    textFieldController.clear();
  });
}
