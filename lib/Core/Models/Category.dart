class UserCategory {
  int _id;
  String _name;
  String _icon;
  String _colorOne;
  String _colorTwo;

  UserCategory();

  UserCategory.fromDb(Map<String, dynamic> data) {
    this._id = data["id"];
    this._name = data["name"];
    this._icon = data["icon"];
    this._colorOne = data["colorOne"];
    this._colorTwo = data["colorTwo"];
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "icon": icon, "colorOne": colorOne, "colorTwo": colorTwo};
  }

  set id(id) {
    _id = id;
  }

  set name(name) {
    _name = name;
  }

  set icon(icon) {
    _icon = icon;
  }

  set colorOne(color) {
    _colorOne = color;
  }

  set colorTwo(color) {
    _colorTwo = color;
  }

  int get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get icon {
    return _icon;
  }

  String get colorOne {
    return _colorOne;
  }

  String get colorTwo {
    return _colorTwo;
  }
}
