class Month {
  Month._privateConstructor();

  static final Month getInstance = Month._privateConstructor();

  DateTime _date;
  int _beginningOfMonthInt;
  int _endOfMonthInt;

  ///Sets the a new date.
  set date(DateTime date) {
    this._date = date;
  }

  set beginningOfMonthInt(int beginningOfMonthInt) {
    this._beginningOfMonthInt = beginningOfMonthInt;
  }

  set endOfMonthInt(int endOfMonthInt) {
    this._endOfMonthInt = endOfMonthInt;
  }

  DateTime get date {
    return this._date;
  }

  int get beginningOfMonthInt {
    return this._beginningOfMonthInt;
  }

  int get endOfMonthInt {
    return this._endOfMonthInt;
  }
}

//Given a date and the month object, sets the month object
void setDate(DateTime date, Month month) {
  //sets the month date to the first
  DateTime beginningOfMonth = DateTime.utc(date.year, date.month, 1);
  DateTime endOfMonth = DateTime.utc(date.year, date.month + 1, 0);
  month.date = beginningOfMonth;
  month.beginningOfMonthInt = beginningOfMonth.millisecondsSinceEpoch;
  month.endOfMonthInt = endOfMonth.millisecondsSinceEpoch;
}
