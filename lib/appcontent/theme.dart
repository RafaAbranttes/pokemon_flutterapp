import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemonapp/appcontent/theme_color.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isOn ? ThemeColor.appBarColorDark : ThemeColor.primaryColor,
      ),
    );
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: ThemeColor.backgourndColorDark,
    colorScheme: ColorScheme.dark(),
    fontFamily: 'Poppins',
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ThemeColor.primaryColor,
      selectionColor: ThemeColor.primaryColor,
      selectionHandleColor: ThemeColor.primaryColor,
    ),
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    fontFamily: 'Poppins',
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ThemeColor.primaryColor,
      selectionColor: ThemeColor.primaryColor,
      selectionHandleColor: ThemeColor.primaryColor,
    ),
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
  );
}
