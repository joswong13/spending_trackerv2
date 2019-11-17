import 'package:flutter/material.dart';
import 'package:spending_tracker/Core/Constants/ErrorCode.dart';

/// Checks [name] to test if it is not empty, and less than 15 characters.
/// Checks [desc], makes sure [desc] is 15 characters or less. Can be empty.
/// Checks [amount], makes sure the double can be parsed and is great than 0.00.
/// Checks [category], to make sure [category] is not default "None".
/// Checks [date] for not null.
Map<String, dynamic> validateTransactionFields(
    {@required String name,
    @required String desc,
    @required String amount,
    @required String category,
    @required DateTime date}) {
  double _tempAmount;

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
  } else if (category == "None" || category.length <= 0) {
    return {"valid": false, "error": ERR_TX_CAT_NULL};
  } else if (date == null) {
    return {"valid": false, "error": ERR_TX_DATE_NULL};
  }
  return {"valid": true};
}

Map<String, dynamic> validateCategoryFields({@required String name, @required String categoryIcon}) {
  if (name == "") {
    return {"valid": false, "error": ERR_CAT_NAME_EMPTY};
  } else if (name.length > 12) {
    return {"valid": false, "error": ERR_CAT_NAME_TOO_LONG};
  } else if (categoryIcon == "Choose Icon" || categoryIcon.length <= 0) {
    return {"valid": false, "error": ERR_CAT_ICON_NULL};
  }
  return {"valid": true};
}
