import 'package:flutter/material.dart';
import 'package:pokemonapp/appcontent/theme.dart';
import 'package:pokemonapp/appcontent/theme_color.dart';
import 'package:provider/provider.dart';

Widget appBar(BuildContext context){
  return AppBar(
    automaticallyImplyLeading: true,
    elevation: 0,
    title: Image.asset("assets/images/pokemon_appbar.png"),
    centerTitle: true,
    backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? ThemeColor.appBarColorDark : ThemeColor.primaryColor,
  );
}