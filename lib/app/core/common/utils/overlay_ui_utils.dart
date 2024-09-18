import 'dart:io';

import 'package:flutter/services.dart';

class OverlayUIUtils {
  static void setOverlayStyle({bool barDark = false}) {
    Brightness brightness = (Platform.isAndroid ? barDark : !barDark) ? Brightness.dark : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: brightness,
        statusBarBrightness: brightness,
        systemNavigationBarIconBrightness: brightness,
      ),
    );
  }
}
