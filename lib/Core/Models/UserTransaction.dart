class UserTransaction {
  int _id;
  String _name;
  double _amount;
  int _date;
  String _category;
  String _desc;
  int _uploaded;

  UserTransaction();

  UserTransaction.fromDb(Map<String, dynamic> data) {
    this._id = data["id"];
    this._name = data["name"];
    this._amount = double.parse(data["amount"].toStringAsFixed(2));
    this._date = data["date"];
    this._category = data["category"];
    this._desc = data["desc"];
    this._uploaded = data["uploaded"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "amount": amount,
      "date": date,
      "category": category,
      "desc": desc,
      "uploaded": uploaded
    };
  }

  set id(id) {
    _id = id;
  }

  set name(name) {
    _name = name;
  }

  set amount(amount) {
    _amount = amount;
  }

  set date(date) {
    _date = date;
  }

  set category(category) {
    _category = category;
  }

  set desc(desc) {
    _desc = desc;
  }

  set uploaded(uploaded) {
    _uploaded = uploaded;
  }

  int get id {
    return _id;
  }

  String get name {
    return _name;
  }

  double get amount {
    return _amount;
  }

  int get date {
    return _date;
  }

  String get category {
    return _category;
  }

  String get desc {
    return _desc;
  }

  int get uploaded {
    return _uploaded;
  }
}
