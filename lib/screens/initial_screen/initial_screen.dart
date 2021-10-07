import 'package:flutter/material.dart';
import 'package:pokemonapp/appcontent/theme_color.dart';
import 'package:pokemonapp/models/user_manager.dart';
import 'package:pokemonapp/screens/routes/routes.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer<UserManager>(builder: (context, userManeger, child) {
        Future.delayed(
          Duration(seconds: 3),
          () {
            if (Provider.of<UserManager>(context, listen: false).isLoggedIn) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  Navigator.of(context)
                      .popAndPushNamed(Routes.HOME_SCREEN);
                },
              );
            } else {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  Navigator.of(context)
                      .popAndPushNamed(Routes.LOGIN_SCREEN);
                },
              );
            }
          },
        );

        return Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: height * 0.07,
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: height * 0.5,
                ),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    color: ThemeColor.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
