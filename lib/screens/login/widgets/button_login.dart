import 'package:flutter/material.dart';
import 'package:pokemonapp/appcontent/string_appcontent.dart';
import 'package:pokemonapp/appcontent/theme_color.dart';
import 'package:pokemonapp/appcontent/validators.dart';
import 'package:pokemonapp/models/user_manager.dart';
import 'package:pokemonapp/models/user_model.dart';
import 'package:pokemonapp/screens/routes/routes.dart';
import 'package:pokemonapp/screens/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

Widget buttonLogin(
    BuildContext context,
    TextEditingController _emailController,
    TextEditingController _passwordController,
    double height,
    double width,
    GlobalKey<FormState> _formKey) {
  return Container(
    margin: EdgeInsets.only(top: height * 0.0335),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ThemeColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            height * 0.0112,
          ),
        ),
        minimumSize: Size(
          width,
          height * 0.0755,
        ),
        elevation: 0,
      ),
      onPressed: () {
        if (_formKey.currentState.validate() &&
            emailValid(_emailController.text.trim()) &&
            _passwordController.text.trim().length >= 6) {
          Provider.of<UserManager>(context, listen: false).signIn(
            user: UserModel(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
            onFail: (e) {
              showSnackBar(
                context,
                "${StringAppContent.falhaAoEntrar} $e",
                ThemeColor.containerFavorite,
              );
            },
            onSuccess: () {
              showSnackBar(
                context,
                StringAppContent.conectado,
                Colors.green,
              );
              Navigator.of(context).pushReplacementNamed(Routes.HOME_SCREEN);
            },
          );
        }
      },
      child: Provider.of<UserManager>(context, listen: false).loading
          ? SizedBox(
              height: height * 0.017,
              width: height * 0.017,
              child: CircularProgressIndicator(
                color: ThemeColor.stringGrey500,
                strokeWidth: 1,
              ),
            )
          : Text(
              StringAppContent.entar,
              style: TextStyle(
                color: ThemeColor.stringGrey500,
                fontSize: height * 0.0224,
              ),
            ),
    ),
  );
}
