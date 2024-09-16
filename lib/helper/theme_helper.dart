import 'package:flutter/material.dart';

class ThemeHelper {
  static Color primaryColor = const Color(0xff3C6FD1);

  static final light = ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch(accentColor: primaryColor),
      dividerColor: Colors.white,
      fontFamily: 'Poppins',
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: primaryColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 17)));
}
