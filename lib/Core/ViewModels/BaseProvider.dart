import 'package:flutter/material.dart';

class BaseProvider with ChangeNotifier {
  bool _busy = false;
  bool _constructorBusy = false;

  set constructorBusy(bool value) {
    this._constructorBusy = value;
    notifyListeners();
  }

  ///Sets busy status or not busy status. The only method used to notify listeners.
  set busy(bool value) {
    this._busy = value;
    notifyListeners();
  }

  ///Used to set widget tree status. Returns the value of the busy status.
  bool get busy {
    return this._busy;
  }

  bool get constructorBusy {
    return this._constructorBusy;
  }
}
