import 'package:flutter/cupertino.dart';

class ChangeTheme extends ChangeNotifier {
  bool isDark = true;
  
  void changer() {
    isDark = !isDark;
    notifyListeners();
  }
}
