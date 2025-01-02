import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigProvider extends ChangeNotifier {
  late bool _isLight;
  bool get isLight => _isLight;

  void setTheme(bool isTheme) async {
    _isLight = isTheme;
    (await SharedPreferences.getInstance()).setBool("Theme", isTheme);
    notifyListeners();
  }
}
