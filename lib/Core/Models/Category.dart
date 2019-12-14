class UserCategory {
  int _id;
  String _name;
  String _icon;
  String _colorOne;
  String _colorTwo;
  int _position;

  UserCategory();

  UserCategory.fromDb(Map<String, dynamic> data) {
    this._id = data["id"];
    this._name = data["name"];
    this._icon = data["icon"];
    this._colorOne = data["colorOne"];
    this._colorTwo = data["colorTwo"];
    this._position = data["position"];
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "icon": icon, "colorOne": colorOne, "colorTwo": colorTwo, "position": position};
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

  set position(position) {
    _position = position;
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

  int get position {
    return _position;
  }

  bool checkEqual(UserCategory uc) {
    bool same = false;
    if (uc.position == _position && uc.name == _name) {
      same = true;
    }
    return same;
  }
}
