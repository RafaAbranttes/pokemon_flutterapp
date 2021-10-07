import 'package:flutter/material.dart';
import 'package:pokemonapp/appcontent/string_appcontent.dart';
import 'package:pokemonapp/appcontent/theme.dart';
import 'package:pokemonapp/appcontent/theme_color.dart';
import 'package:pokemonapp/appcontent/validators.dart';
import 'package:pokemonapp/models/user_manager.dart';
import 'package:pokemonapp/screens/login/controller/login_signup_controller.dart';
import 'package:pokemonapp/screens/login/widgets/button_signup.dart';
import 'package:pokemonapp/screens/widgets/app_bar.dart';
import 'package:pokemonapp/screens/widgets/footer.dart';
import 'package:pokemonapp/screens/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double paddingAppBar = AppBar().preferredSize.height;
    double paddingStatus = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: width,
                  height: height - paddingAppBar - paddingStatus,
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "assets/images/image_background_login.png",
                    fit: BoxFit.contain,
                    width: width,
                  ),
                ),
                Consumer<UserManager>(
                  builder: (context, userManager, child) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: width * 0.064,
                        ),
                        height:
                            (height - paddingAppBar - paddingStatus) * 0.9231,
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width * 0.9,
                              child: Text(
                                StringAppContent.cadastre,
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? ThemeColor.primaryColor
                                      : ThemeColor.stringGrey500,
                                  fontWeight: FontWeight.w700,
                                  fontSize: height * 0.033,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: height * 0.015,
                              ),
                              width: width * 0.9,
                              child: Row(
                                children: [
                                  Text(
                                    StringAppContent.jaTemUmaConta,
                                    style: TextStyle(
                                      color:
                                          !Provider.of<ThemeProvider>(context)
                                                  .isDarkMode
                                              ? ThemeColor.stringGrey300
                                              : Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: height * 0.017,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      " ${StringAppContent.facaLogin}",
                                      style: TextStyle(
                                        color:
                                            !Provider.of<ThemeProvider>(context)
                                                    .isDarkMode
                                                ? ThemeColor.primaryColor
                                                : ThemeColor.primaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: height * 0.017,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.0559 -
                                      height * 0.017 -
                                      height * 0.015),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      height: height * 0.0755,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        autocorrect: false,
                                        controller: _firstName,
                                        readOnly: userManager.loading,
                                        cursorColor: ThemeColor.primaryColor,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: !Provider.of<ThemeProvider>(
                                                        context)
                                                    .isDarkMode
                                                ? ThemeColor.stringGrey300
                                                : Colors.white,
                                          ),
                                          hintText:
                                              StringAppContent.primeiroNome,
                                          hintStyle: TextStyle(
                                            color: !Provider.of<ThemeProvider>(
                                                        context)
                                                    .isDarkMode
                                                ? ThemeColor.stringGrey300
                                                : Colors.white,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              height * 0.0112,
                                            ),
                                            borderSide: BorderSide(
                                              color: ThemeColor.primaryColor,
                                              width: 1,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              height * 0.0112,
                                            ),
                                            borderSide: BorderSide(
                                              color: Provider.of<
                                                              signUpController>(
                                                          context)
                                                      .firstName
                                                  ? ThemeColor.containerFavorite
                                                  : !Provider.of<ThemeProvider>(
                                                              context)
                                                          .isDarkMode
                                                      ? ThemeColor.stringGrey300
                                                      : Colors.white,
                                              width: 1,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              height * 0.0112,
                                            ),
                                            borderSide: BorderSide(
                                              color:
                                                  ThemeColor.containerFavorite,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        validator: (name) {
                                          if (name.trim().length == 0) {
                                            showSnackBar(
                                              context,
                                              StringAppContent.nomeInvalido,
                                              ThemeColor.containerFavorite,
                                            );
                                            Provider.of<signUpController>(
                                                    context,
                                                    listen: false)
                                                .firstName = true;
                                          } else {
                                            Provider.of<signUpController>(
                                                    context,
                                                    listen: false)
                                                .firstName = false;
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                          color: !Provider.of<ThemeProvider>(
                                                      context)
                                                  .isDarkMode
                                              ? ThemeColor.stringGrey300
                                              : Colors.white,
                                          fontSize: height * 0.0168,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.021,
                                    ),
                                    Container(
                                      height: height * 0.0755,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        autocorrect: false,
                                        controller: _lastName,
                                        readOnly: userManager.loading,
                                        cursorColor: ThemeColor.primaryColor,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: !Provider.of<ThemeProvider>(
                                                        context)
                                                    .isDarkMode
                                                ? ThemeColor.stringGrey300
                                                : Colors.white,
                                          ),
                                          hintText: StringAppContent.sobrenome,
                                          hintStyle: TextStyle(
                                            color: !Provider.of<ThemeProvider>(
                                                        context)
                                                    .isDarkMode
                                                ? ThemeColor.stringGrey300
                                                : Colors.white,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              height * 0.0112,
                                            ),
                                            borderSide: BorderSide(
                                              color: ThemeColor.primaryColor,
                                              width: 1,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              height * 0.0112,
                                            ),
                                            borderSide: BorderSide(
                                              color: Provider.of<
                                                              signUpController>(
                                                          context)
                                                      .lastName
                                                  ? ThemeColor.containerFavorite
                                                  : !Provider.of<ThemeProvider>(
                                                              context)
                                                          .isDarkMode
                                                      ? ThemeColor.stringGrey300
                                                      : Colors.white,
                                              width: 1,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              height * 0.0112,
                                            ),
                                            borderSide: BorderSide(
                                              color:
                                                  ThemeColor.containerFavorite,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        validator: (lastName) {
                                          if (lastName.trim().length == 0) {
                                            showSnackBar(
                                              context,
                                              StringAppContent
                                                  .sobrenomeInvalido,
                                              ThemeColor.containerFavorite,
                                            );
                                            Provider.of<signUpController>(
                                                    context,
                                                    listen: false)
                                                .lastName = true;
                                          } else {
                                            Provider.of<signUpController>(
                                                    context,
                                                    listen: false)
                                                .lastName = false;
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                          color: !Provider.of<ThemeProvider>(
                                                      context)
                                                  .isDarkMode
                                              ? ThemeColor.stringGrey300
                                              : Colors.white,
                                          fontSize: height * 0.0168,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.021,
                                    ),
                                    Container(
                                      height: height * 0.0755,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        autocorrect: false,
                                        controller: _emailController,
                                        readOnly: userManager.loading,
                                        cursorColor: ThemeColor.primaryColor,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: !Provider.of<ThemeProvider>(
                                                        context)
                                                    .isDarkMode
                                                ? ThemeColor.stringGrey300
                                                : Colors.white,
                                          ),
                                          hintText: StringAppContent.email,
                                          hintStyle: TextStyle(
                                            color: !Provider.of<ThemeProvider>(
                                                        context)
                                                    .isDarkMode
                                                ? ThemeColor.stringGrey300
                                                : Colors.white,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              height * 0.0112,
                                            ),
                                            borderSide: BorderSide(
                                              color: ThemeColor.primaryColor,
                                              width: 1,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              height * 0.0112,
                                            ),
                                            borderSide: BorderSide(
                                              color: Provider.of<
                                                              signUpController>(
                                                          context)
                                                      .emailInvalido
                                                  ? ThemeColor.containerFavorite
                                                  : !Provider.of<ThemeProvider>(
                                                              context)
                                                          .isDarkMode
                                                      ? ThemeColor.stringGrey300
                                                      : Colors.white,
                                              width: 1,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              height * 0.0112,
                                            ),
                                            borderSide: BorderSide(
                                              color:
                                                  ThemeColor.containerFavorite,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        validator: (email) {
                                          if (!emailValid(email.trim())) {
                                            showSnackBar(
                                              context,
                                              StringAppContent.emailInvalido,
                                              ThemeColor.containerFavorite,
                                            );
                                            Provider.of<signUpController>(
                                                    context,
                                                    listen: false)
                                                .emailInvalido = true;
                                          } else {
                                            Provider.of<signUpController>(
                                                    context,
                                                    listen: false)
                                                .emailInvalido = false;
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                          color: !Provider.of<ThemeProvider>(
                                                      context)
                                                  .isDarkMode
                                              ? ThemeColor.stringGrey300
                                              : Colors.white,
                                          fontSize: height * 0.0168,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.021,
                                    ),
                                    Container(
                                      height: height * 0.0755,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.done,
                                        autocorrect: false,
                                        obscureText: true,
                                        controller: _passwordController,
                                        readOnly: userManager.loading,
                                        cursorColor: ThemeColor.primaryColor,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: !Provider.of<ThemeProvider>(
                                                        context)
                                                    .isDarkMode
                                                ? ThemeColor.stringGrey300
                                                : Colors.white,
                                          ),
                                          hintText: StringAppContent.senha,
                                          hintStyle: TextStyle(
                                            color: !Provider.of<ThemeProvider>(
                                                        context)
                                                    .isDarkMode
                                                ? ThemeColor.stringGrey300
                                                : Colors.white,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              height * 0.0112,
                                            ),
                                            borderSide: BorderSide(
                                              color: ThemeColor.primaryColor,
                                              width: 1,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              height * 0.0112,
                                            ),
                                            borderSide: BorderSide(
                                              color: Provider.of<
                                                              signUpController>(
                                                          context,
                                                          listen: false)
                                                      .senhaInvalida
                                                  ? ThemeColor.containerFavorite
                                                  : !Provider.of<ThemeProvider>(
                                                              context)
                                                          .isDarkMode
                                                      ? ThemeColor.stringGrey300
                                                      : Colors.white,
                                              width: 1,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              height * 0.0112,
                                            ),
                                            borderSide: BorderSide(
                                              color:
                                                  ThemeColor.containerFavorite,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        validator: (password) {
                                          if (password.trim().length <= 6) {
                                            showSnackBar(
                                              context,
                                              StringAppContent.senhaInvalida,
                                              ThemeColor.containerFavorite,
                                            );
                                            Provider.of<signUpController>(
                                                    context,
                                                    listen: false)
                                                .senhaInvalida = true;
                                          } else {
                                            Provider.of<signUpController>(
                                                    context,
                                                    listen: false)
                                                .senhaInvalida = false;
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                            color: !Provider.of<ThemeProvider>(
                                                        context)
                                                    .isDarkMode
                                                ? ThemeColor.stringGrey300
                                                : Colors.white,
                                            fontSize: height * 0.0168),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            buttonSignUp(
                              context,
                              _emailController,
                              _passwordController,
                              _firstName,
                              _lastName,
                              height,
                              width,
                              _formKey,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  child: footerApp(
                    isLogin: true,
                    context: context,
                    height: height,
                    width: width,
                    appBar: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
