import 'package:flutter/material.dart';
import 'package:pokemonapp/appcontent/string_appcontent.dart';
import 'package:pokemonapp/appcontent/theme.dart';
import 'package:pokemonapp/appcontent/theme_color.dart';
import 'package:pokemonapp/models/user_manager.dart';
import 'package:pokemonapp/screens/routes/routes.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

Widget footerApp({
  bool isLogin = false,
  BuildContext context,
  double height,
  double width,
  bool appBar = false,
}) {
  double paddingAppBar = AppBar().preferredSize.height;
  double paddingStatus = MediaQuery.of(context).padding.top;

  Widget rowButton(BuildContext context, double width, double height) {
    return Container(
      
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.3707,
            height: height * 0.0434,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Provider.of<ThemeProvider>(context).isDarkMode
                    ? ThemeColor.backgourndColorDark
                    : ThemeColor.buttonThemeDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    height * 0.031,
                  ),
                ),
                side: BorderSide(
                  width: 1,
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white
                      : ThemeColor.buttonThemeDark,
                ),
                minimumSize: Size(
                  width * 0.3707,
                  height * 0.0434,
                ),
              ),
              onPressed: () {
                final provider =
                    Provider.of<ThemeProvider>(context, listen: false);
                if (Provider.of<ThemeProvider>(context, listen: false)
                        .themeMode ==
                    ThemeMode.dark) {
                  provider.toggleTheme(false);
                } else {
                  provider.toggleTheme(true);
                }
              },
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.021,
                      alignment: Alignment.center,
                      child: !Provider.of<ThemeProvider>(context).isDarkMode
                          ? Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(math.pi),
                              child: Icon(
                                Icons.dark_mode,
                                color: ThemeColor.stringGrey200,
                                size: height * 0.021,
                              ),
                            )
                          : Icon(
                              Icons.light_mode,
                              color: ThemeColor.stringGrey200,
                              size: height * 0.021,
                            ),
                    ),
                    SizedBox(
                      width: width * 0.0213,
                    ),
                    Text(
                      !Provider.of<ThemeProvider>(context).isDarkMode
                          ? StringAppContent.temaEscuro
                          : StringAppContent.temaClaro,
                      style: TextStyle(
                        color: ThemeColor.stringGrey200,
                        fontSize: height * 0.0168,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          !isLogin
              ? SizedBox(
                  width: width * 0.23733,
                  height: height * 0.0434,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.buttonThemeDark
                          : Colors.white,
                      padding: EdgeInsets.only(
                        left: width * 0.024,
                        top: width * 0.0133,
                        bottom: width * 0.0133,
                        right: width * 0.0245,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          height * 0.0112,
                        ),
                      ),
                      side: BorderSide(
                        width: 1,
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonThemeDark,
                      ),
                      minimumSize: Size(
                        width * 0.23733,
                        height * 0.0434,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<UserManager>(context, listen: false)
                          .signOut();
                      Navigator.of(context).popAndPushNamed(
                        Routes.LOGIN_SCREEN,
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: (width * 0.23733) -
                              (width * 0.0213) -
                              (height * 0.021) -
                              (width * 0.024) -
                              (width * 0.0245),
                          child: Text(
                            StringAppContent.sair,
                            style: TextStyle(
                              color:
                                  Provider.of<ThemeProvider>(context).isDarkMode
                                      ? ThemeColor.stringGrey200
                                      : ThemeColor.stringButtonSignOut,
                              fontSize: height * 0.0168,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.logout,
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? ThemeColor.stringGrey200
                              : ThemeColor.stringButtonSignOut,
                          size: height * 0.021,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  return Container(
    
    height: appBar ? height - paddingAppBar - paddingStatus : height,
    alignment: Alignment.bottomCenter,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: isLogin ? Colors.transparent : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
          height: height * 0.112,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.064,
            ),
            child: rowButton(
              context,
              width,
              height,
            ),
          ),
        ),
      ],
    ),
  );
}
