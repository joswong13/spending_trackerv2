import 'package:flutter/material.dart';

@immutable
class Stat {
  final double _total;
  final List<StatMonth> _statMonth;
  final List<StatCategory> _statCategory;
  final int _numberOfTransactions;

  /// This class is immutable and can only be used to generate a Stat object.
  Stat(this._total, this._statMonth, this._statCategory, this._numberOfTransactions);

  double get total {
    return this._total;
  }

  int get numberOfTransactions {
    return this._numberOfTransactions;
  }

  List<StatMonth> get statMonth {
    return this._statMonth;
  }

  List<StatCategory> get statCategory {
    return this._statCategory;
  }
}

class StatMonth {
  double _total;
  int _numberOfTransactions;
  int _month;
  int _year;
  int _dateMillisecondsSinceEpoch;
  DateTime _date;

  StatMonth(
      this._total, this._numberOfTransactions, this._month, this._year, this._dateMillisecondsSinceEpoch, this._date);

  set total(double total) {
    this._total = total;
  }

  set numberOfTransactions(int numOfTx) {
    this._numberOfTransactions = numOfTx;
  }

  double get total {
    return this._total;
  }

  int get numberOfTransactions {
    return this._numberOfTransactions;
  }

  int get month {
    return this._month;
  }

  int get year {
    return this._year;
  }

  int get dateMillisecondsSinceEpoch {
    return this._dateMillisecondsSinceEpoch;
  }

  DateTime get date {
    return this._date;
  }
}

class StatCategory {
  double _total;
  int _numberOfTransactions;
  String _category;
  String _icon;

  StatCategory(this._category, this._total, this._numberOfTransactions, this._icon);

  set total(double total) {
    this._total = total;
  }

  set numberOfTransactions(int numOfTx) {
    this._numberOfTransactions = numOfTx;
  }

  double get total {
    return this._total;
  }

  String get category {
    return this._category;
  }

  String get icon {
    return this._icon;
  }

  int get numberOfTransactions {
    return this._numberOfTransactions;
  }

  //maybe a list of tx
}
