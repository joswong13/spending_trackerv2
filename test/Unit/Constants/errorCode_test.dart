import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Constants/ErrorCode.dart';

void main() {
  test("test error constant string", () {
    expect(ERR_CAT_NAME_TOO_LONG, "Error: Category name is too long. Please reduce name to 12 characters or less.");
    expect(ERR_CAT_NAME_EMPTY, "Error: Category name cannot be empty.");
    expect(ERR_CAT_ICON_NULL, "Error: Need category icon.");
    expect(ERR_CAT_EXISTS, "Category name already exists.");
    expect(ERR_TX_AMOUNT_DOUBLE_ERROR, "Error: Amount cannot be less than or equal to 0.0.");
    expect(ERR_TX_AMOUNT_PARSE_ERROR, "Error: Amount input error.");
    expect(ERR_TX_NAME_EMPTY, "Error: Name cannot be empty.");
    expect(ERR_TX_NAME_TOO_LONG, "Error: Name is too long. Please reduce name to 15 characters or less.");
    expect(ERR_TX_DESC_TOO_LONG, "Error: Description is too long. Please reduce description to 15 characters or less.");
    expect(ERR_TX_CAT_NULL, "Error: Category cannot be none.");
    expect(ERR_TX_DATE_NULL, "Error: Date has not been picked.");
    expect(ERR_STAT_END_DATE, "Error: The end date is greater than the beginning date.");
    expect(ERR_DATE_PAST_BACKLIMIT, "Unable to move date back further.");
    expect(ERR_DATE_PAST_FORWARDLIMIT, "Unable to move date forward.");
  });
}
