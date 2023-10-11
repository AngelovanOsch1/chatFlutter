import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  Map<String, dynamic>? _userData;

  Map<String, dynamic>? get userData => _userData;

  void setData(Map<String, dynamic>? newData) {
    _userData = newData;
    debugPrint(newData.toString());
    notifyListeners();
  }
}
