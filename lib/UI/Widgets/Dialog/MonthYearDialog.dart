import 'package:flutter/material.dart';

Future<DateTime> monthYearPicker(BuildContext context, DateTime selectedDate) async {
  DateTime datePicked = await showDatePicker(
      context: context,
      initialDate: selectedDate == null ? DateTime.now() : selectedDate,
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year);
  if (datePicked == null) {
    return selectedDate;
  } else {
    return DateTime.utc(datePicked.year, datePicked.month, datePicked.day);
  }
}
