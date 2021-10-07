import 'package:flutter/material.dart';
import 'package:pokemonapp/api/poke_api.dart';
import 'package:pokemonapp/appcontent/string_appcontent.dart';
import 'package:pokemonapp/appcontent/theme.dart';
import 'package:pokemonapp/appcontent/theme_color.dart';
import 'package:pokemonapp/models/user_manager.dart';
import 'package:pokemonapp/screens/detail/arguments/pokemon_detail_arguments.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PokemonDetail extends StatefulWidget {
  PokemonDetailArguments pokemonDetailArguments;

  PokemonDetail(this.pokemonDetailArguments);

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.08,
        backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
            ? ThemeColor.backgourndColorDark
            : Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.only(
            left: width * 0.064,
          ),
          child: Text(
            StringAppContent.detalhes,
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? ThemeColor.primaryColor
                  : ThemeColor.stringButtonSignOut,
              fontWeight: FontWeight.w400,
              fontSize: height * 0.0224,
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(
              right: width * 0.064,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? ThemeColor.primaryColor
                    : ThemeColor.stringButtonSignOut,
              ),
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: Container(
        width: width,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 1,
              width: width - (2 * (width * 0.064)),
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? ThemeColor.primaryColor
                  : ThemeColor.lineContainerDetail,
            ),
            Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: width * 0.064,
                        right: width * 0.064,
                        top: height * 0.05,
                      ),
                      width: width - (2 * (width * 0.064)),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.pokemonDetailArguments.namePokemon[0]
                                .toUpperCase() +
                            widget.pokemonDetailArguments.namePokemon.substring(
                              1,
                              widget.pokemonDetailArguments.namePokemon.length,
                            ),
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? ThemeColor.primaryColor
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: height * 0.03356,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: width * 0.064,
                        right: width * 0.064,
                        top: height * 0.0182,
                      ),
                      width: width - (2 * (width * 0.064)),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Container(
                            height: height * 0.1175,
                            width: height * 0.1175,
                            child: Card(
                              color:
                                  Provider.of<ThemeProvider>(context).isDarkMode
                                      ? ThemeColor.appBarColorDark
                                      : ThemeColor.cardColorDetail,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  width * 0.01868,
                                ),
                              ),
                              child: Image.network(
                                widget.pokemonDetailArguments.url,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.1175,
                            width: height * 0.1175,
                            child: Card(
                              color:
                                  Provider.of<ThemeProvider>(context).isDarkMode
                                      ? ThemeColor.appBarColorDark
                                      : ThemeColor.cardColorDetail,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  width * 0.01868,
                                ),
                              ),
                              child: Image.network(
                                widget.pokemonDetailArguments.url2,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: width * 0.064,
                        right: width * 0.064,
                        top: height * 0.03,
                      ),
                      width: width - (2 * (width * 0.064)),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            (widget.pokemonDetailArguments.height /
                                        10.toDouble())
                                    .toString() +
                                "m",
                            style: TextStyle(
                              color:
                                  Provider.of<ThemeProvider>(context).isDarkMode
                                      ? ThemeColor.primaryColor
                                      : Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: height * 0.0252,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text(
                            (widget.pokemonDetailArguments.weight /
                                        10.toDouble())
                                    .toString() +
                                "Kg",
                            style: TextStyle(
                              color:
                                  Provider.of<ThemeProvider>(context).isDarkMode
                                      ? ThemeColor.primaryColor
                                      : Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: height * 0.0252,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: width * 0.064,
                        right: width * 0.064,
                        top: height * 0.03,
                      ),
                      width: width - (2 * (width * 0.064)),
                      height: height * 0.05,
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.pokemonDetailArguments.type.length,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              right: width * 0.01,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.015,
                            ),
                            decoration: BoxDecoration(
                              color: index == 0
                                  ? ThemeColor.primaryColor
                                  : ThemeColor.containerFavorite,
                              borderRadius: BorderRadius.all(
                                Radius.circular(width * 0.01868),
                              ),
                            ),
                            height: height * 0.05,
                            width: width * 0.24,
                            child: Text(
                              widget.pokemonDetailArguments.type[index],
                              style: TextStyle(
                                color: index == 0
                                    ? ThemeColor.stringGrey500
                                    : Colors.white,
                                fontSize: height * 0.015,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: width * 0.064,
                        right: width * 0.064,
                        top: height * 0.045,
                      ),
                      width: width - (2 * (width * 0.064)),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              StringAppContent.estatisticas,
                              style: TextStyle(
                                color: ThemeColor.stringEstatisticas,
                                fontWeight: FontWeight.w600,
                                fontSize: height * 0.0182,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.095,
                                child: Text(
                                  "HP",
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context)
                                            .isDarkMode
                                        ? Colors.white
                                        : ThemeColor.stringDataEstatisticas,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.0168,
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.65,
                                height: height * 0.0125,
                                decoration: BoxDecoration(
                                  color: ThemeColor.containerEstatisticas,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      width * 0.02133,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: (width * 0.65) *
                                      (widget.pokemonDetailArguments.hp / 100),
                                  height: height * 0.0125,
                                  decoration: BoxDecoration(
                                    color: ThemeColor.primaryColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        width * 0.02133,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Text(
                                widget.pokemonDetailArguments.hp.toString(),
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : ThemeColor.stringDataEstatisticas,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.0168,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.095,
                                child: Text(
                                  "ATK",
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context)
                                            .isDarkMode
                                        ? Colors.white
                                        : ThemeColor.stringDataEstatisticas,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.0168,
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.65,
                                height: height * 0.0125,
                                decoration: BoxDecoration(
                                  color: ThemeColor.containerEstatisticas,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      width * 0.02133,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: (width * 0.65) *
                                      (widget.pokemonDetailArguments.attack /
                                          100),
                                  height: height * 0.0125,
                                  decoration: BoxDecoration(
                                    color: ThemeColor.primaryColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        width * 0.02133,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Text(
                                widget.pokemonDetailArguments.attack.toString(),
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : ThemeColor.stringDataEstatisticas,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.0168,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.095,
                                child: Text(
                                  "DEF",
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context)
                                            .isDarkMode
                                        ? Colors.white
                                        : ThemeColor.stringDataEstatisticas,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.0168,
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.65,
                                height: height * 0.0125,
                                decoration: BoxDecoration(
                                  color: ThemeColor.containerEstatisticas,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      width * 0.02133,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: (width * 0.65) *
                                      (widget.pokemonDetailArguments.defense /
                                          100),
                                  height: height * 0.0125,
                                  decoration: BoxDecoration(
                                    color: ThemeColor.primaryColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        width * 0.02133,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Text(
                                widget.pokemonDetailArguments.defense
                                    .toString(),
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : ThemeColor.stringDataEstatisticas,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.0168,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.095,
                                child: Text(
                                  "S.ATK",
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context)
                                            .isDarkMode
                                        ? Colors.white
                                        : ThemeColor.stringDataEstatisticas,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.0168,
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.65,
                                height: height * 0.0125,
                                decoration: BoxDecoration(
                                  color: ThemeColor.containerEstatisticas,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      width * 0.02133,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: (width * 0.65) *
                                      (widget.pokemonDetailArguments
                                              .specialAttack /
                                          100),
                                  height: height * 0.0125,
                                  decoration: BoxDecoration(
                                    color: ThemeColor.primaryColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        width * 0.02133,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Text(
                                widget.pokemonDetailArguments.specialAttack
                                    .toString(),
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : ThemeColor.stringDataEstatisticas,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.0168,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.095,
                                child: Text(
                                  "S.DEF",
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context)
                                            .isDarkMode
                                        ? Colors.white
                                        : ThemeColor.stringDataEstatisticas,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.0168,
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.65,
                                height: height * 0.0125,
                                decoration: BoxDecoration(
                                  color: ThemeColor.containerEstatisticas,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      width * 0.02133,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: (width * 0.65) *
                                      (widget.pokemonDetailArguments
                                              .specialDefence /
                                          100),
                                  height: height * 0.0125,
                                  decoration: BoxDecoration(
                                    color: ThemeColor.primaryColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        width * 0.02133,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Text(
                                widget.pokemonDetailArguments.specialDefence
                                    .toString(),
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : ThemeColor.stringDataEstatisticas,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.0168,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.095,
                                child: Text(
                                  "SPD",
                                  style: TextStyle(
                                    color: Provider.of<ThemeProvider>(context)
                                            .isDarkMode
                                        ? Colors.white
                                        : ThemeColor.stringDataEstatisticas,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.0168,
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.65,
                                height: height * 0.0125,
                                decoration: BoxDecoration(
                                  color: ThemeColor.containerEstatisticas,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      width * 0.02133,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: (width * 0.65) *
                                      (widget.pokemonDetailArguments.speed /
                                          100),
                                  height: height * 0.0125,
                                  decoration: BoxDecoration(
                                    color: ThemeColor.primaryColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        width * 0.02133,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Text(
                                widget.pokemonDetailArguments.speed.toString(),
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : ThemeColor.stringDataEstatisticas,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.0168,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: width * 0.064,
                        right: width * 0.064,
                        top: height * 0.038,
                      ),
                      width: width - (2 * (width * 0.064)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              height * 0.0112,
                            ),
                          ),
                          elevation: 0,
                          minimumSize: Size(
                            width * 0.8827,
                            height * 0.06433,
                          ),
                          primary: widget.pokemonDetailArguments.isFavorite
                              ? ThemeColor.containerFavorite
                              : ThemeColor.primaryColor,
                        ),
                        onPressed: () {
                          if (widget.pokemonDetailArguments.isFavorite) {
                            Provider.of<PokeApi>(context, listen: false)
                                .deleteFavorite(
                              Provider.of<UserManager>(context, listen: false)
                                  .user
                                  .id,
                              widget.pokemonDetailArguments.id,
                              widget.pokemonDetailArguments.type,
                            );
                            setState(() {
                              widget.pokemonDetailArguments.isFavorite = false;
                            });
                          } else {
                            Provider.of<PokeApi>(context, listen: false)
                                .setFavorite(
                              userId: Provider.of<UserManager>(context,
                                      listen: false)
                                  .user
                                  .id,
                              idPokemon: widget.pokemonDetailArguments.id,
                              namePokemon:
                                  widget.pokemonDetailArguments.namePokemon,
                              url: widget.pokemonDetailArguments.url,
                              url2: widget.pokemonDetailArguments.url2,
                              type: widget.pokemonDetailArguments.type,
                              attack: widget.pokemonDetailArguments.attack,
                              defense: widget.pokemonDetailArguments.defense,
                              height: widget.pokemonDetailArguments.height,
                              weight: widget.pokemonDetailArguments.weight,
                              hp: widget.pokemonDetailArguments.hp,
                              specialAttack:
                                  widget.pokemonDetailArguments.specialAttack,
                              specialDefence:
                                  widget.pokemonDetailArguments.specialDefence,
                              speed: widget.pokemonDetailArguments.speed,
                            );
                            setState(() {
                              widget.pokemonDetailArguments.isFavorite = true;
                            });
                          }
                        },
                        child: widget.pokemonDetailArguments.isFavorite
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    StringAppContent.removerFavoritos,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: height * 0.0168,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.bookmark_border,
                                    color: ThemeColor.stringGrey500,
                                  ),
                                  SizedBox(
                                    width: width * 0.015,
                                  ),
                                  Text(
                                    StringAppContent.adicionarFavoritos,
                                    style: TextStyle(
                                      color: ThemeColor.stringGrey500,
                                      fontWeight: FontWeight.w500,
                                      fontSize: height * 0.0168,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
