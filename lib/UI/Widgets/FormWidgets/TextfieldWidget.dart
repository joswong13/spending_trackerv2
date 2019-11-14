import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
Map<String, dynamic> checkValidFields({String name, String amount, String category, DateTime date}) {
  double _tempAmount;
  Map<String, dynamic> validatorMap;

  // add more amount checks
  try {
    _tempAmount = double.parse(amount);
  } catch (e) {
    return validatorMap = {"valid": false, "error": "Error: Amount error."};
  }
  if (name == "") {
    return validatorMap = {"valid": false, "error": "Error: Name cannot be empty."};
  } else if (_tempAmount <= 0.00) {
    return validatorMap = {"valid": false, "error": "Error: Amount cannot be less than or equal to 0.0."};
  } else if (category == "None") {
    return validatorMap = {"valid": false, "error": "Error: Category cannot be none."};
  } else if (date == null) {
    return validatorMap = {"valid": false, "error": "Error: Date has not been picked."};
  }
  return validatorMap = {"valid": true};
}

///Given a FocusNode and the TextFieldController, this will unfocus and clear the text field.
void textfieldFullClearUnfocus({FocusNode focusNode, TextEditingController textFieldController}) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    focusNode.unfocus();
    textFieldController.clear();
  });
}
