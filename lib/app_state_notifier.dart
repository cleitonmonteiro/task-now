import 'package:flutter/foundation.dart';

class AppStateNotifier extends ChangeNotifier {
  bool isDarkModeOn = false;

  void updateTheme(bool isDarkMode) {
    this.isDarkModeOn = isDarkMode;
    notifyListeners();
  }
}
