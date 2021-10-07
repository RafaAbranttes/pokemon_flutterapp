import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pokemonapp/api/poke_api.dart';
import 'package:pokemonapp/appcontent/string_appcontent.dart';
import 'package:pokemonapp/appcontent/theme.dart';
import 'package:pokemonapp/appcontent/theme_color.dart';
import 'package:pokemonapp/models/pokemonApi/pokemon_dto.dart';
import 'package:pokemonapp/models/user_manager.dart';
import 'package:pokemonapp/screens/home/controller/controller_pokemons.dart';
import 'package:pokemonapp/screens/home/widgets/card_pokemon.dart';
import 'package:provider/provider.dart';

class SeeAllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: height * 0.2326,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: height * 0.2326,
                ),
                items: [
                  page1(context, height, width),
                  page2(context, height, width),
                  page3(context, height, width),
                  page4(context, height, width),
                  page5(context, height, width),
                ],
              ),
            ),
            Expanded(
              child: Consumer<PokeApi>(
                builder: (context, pokeApi, child) {
                  if (pokeApi.loading) {
                    return Center(
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          color: ThemeColor.primaryColor,
                        ),
                      ),
                    );
                  } else {
                    if (pokeApi.listPokemon == null ||
                        pokeApi.listPokemon.length == 1) {
                      return Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: ThemeColor.primaryColor,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.only(
                          left: width * 0.064,
                          right: width * 0.064,
                          bottom: height * 0.128,
                        ),
                        child: GridView.count(
                          childAspectRatio: (3 / 4),
                          crossAxisCount: 2,
                          children: List.generate(
                             pokeApi.offset + 1,
                            (index) {
                              return index == pokeApi.offset
                                  ? Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          width * 0.01868,
                                        ),
                                      ),
                                      elevation: 2,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          primary: ThemeColor.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              width * 0.01868,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (Provider.of<ControllerPokemons>(
                                                      context,
                                                      listen: false)
                                                  .nameType ==
                                              StringAppContent.todos
                                                  .toLowerCase()) {
                                            Provider.of<PokeApi>(context,
                                                    listen: false)
                                                .getListPokemonAll(
                                              20,
                                            );
                                          } else {
                                            List<
                                                PokemonDto> list = await Provider
                                                    .of<PokeApi>(context,
                                                        listen: false)
                                                .fetchPokemonsByType(Provider
                                                        .of<ControllerPokemons>(
                                                            context,
                                                            listen: false)
                                                    .nameType);
                                            Provider.of<PokeApi>(context,
                                                    listen: false)
                                                .getListPokemon(
                                                    list,
                                                    20,
                                                    Provider.of<UserManager>(
                                                            context,
                                                            listen: false)
                                                        .user
                                                        .id);
                                          }
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: ThemeColor.stringGrey500,
                                        ),
                                      ),
                                    )
                                  : cardPokemon(
                                      context: context,
                                      height: height,
                                      width: width,
                                      pokemon: Provider.of<PokeApi>(context,
                                              listen: false)
                                          .listPokemon[index + 1],
                                    );
                            },
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget page1(BuildContext context, double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          0
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            0
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 0;
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.todos.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;

                  Provider.of<PokeApi>(context, listen: false)
                      .getListPokemonAll(
                    0,
                  );
                },
                child: Text(
                  StringAppContent.todos,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            0
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          1
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            1
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.normal.toLowerCase();
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 1;
                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list =
                      await Provider.of<PokeApi>(context, listen: false)
                          .fetchPokemonsByType(
                              StringAppContent.normal.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.normal,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            1
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02377,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          2
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            2
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 2;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.fighting.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list =
                      await Provider.of<PokeApi>(context, listen: false)
                          .fetchPokemonsByType(
                              StringAppContent.fighting.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.fighting,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            2
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          3
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            3
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 3;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.flying.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list =
                      await Provider.of<PokeApi>(context, listen: false)
                          .fetchPokemonsByType(
                              StringAppContent.flying.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.flying,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            3
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget page2(BuildContext context, double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          4
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            4
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 4;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.poison.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list =
                      await Provider.of<PokeApi>(context, listen: false)
                          .fetchPokemonsByType(
                              StringAppContent.poison.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.poison,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            4
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          5
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            5
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 5;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.ground.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list =
                      await Provider.of<PokeApi>(context, listen: false)
                          .fetchPokemonsByType(
                              StringAppContent.ground.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.ground,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            5
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02377,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          6
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            6
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 6;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.rock.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list = await Provider.of<PokeApi>(context,
                          listen: false)
                      .fetchPokemonsByType(StringAppContent.rock.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.rock,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            6
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          7
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            7
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 7;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.bug.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list = await Provider.of<PokeApi>(context,
                          listen: false)
                      .fetchPokemonsByType(StringAppContent.bug.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.bug,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            7
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget page3(BuildContext context, double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          8
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            8
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 8;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.ghost.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list =
                      await Provider.of<PokeApi>(context, listen: false)
                          .fetchPokemonsByType(
                              StringAppContent.ghost.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.ghost,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            8
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          9
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            9
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 9;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.steel.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list =
                      await Provider.of<PokeApi>(context, listen: false)
                          .fetchPokemonsByType(
                              StringAppContent.steel.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.steel,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            9
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02377,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          10
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            10
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 10;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.fire.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list = await Provider.of<PokeApi>(context,
                          listen: false)
                      .fetchPokemonsByType(StringAppContent.fire.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.fire,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            10
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          11
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            11
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 11;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.water.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list =
                      await Provider.of<PokeApi>(context, listen: false)
                          .fetchPokemonsByType(
                              StringAppContent.water.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.water,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            11
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget page4(BuildContext context, double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          12
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            12
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 12;
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.grass.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list =
                      await Provider.of<PokeApi>(context, listen: false)
                          .fetchPokemonsByType(
                              StringAppContent.grass.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.grass,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            12
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          13
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            13
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 13;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.electric.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list =
                      await Provider.of<PokeApi>(context, listen: false)
                          .fetchPokemonsByType(
                              StringAppContent.electric.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.electric,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            13
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02377,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          14
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            14
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 14;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.psychic.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list =
                      await Provider.of<PokeApi>(context, listen: false)
                          .fetchPokemonsByType(
                              StringAppContent.psychic.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.psychic,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            14
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          15
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            15
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 15;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.ice.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list = await Provider.of<PokeApi>(context,
                          listen: false)
                      .fetchPokemonsByType(StringAppContent.ice.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.ice,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            15
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget page5(BuildContext context, double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          16
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            16
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 16;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.dragon.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list =
                      await Provider.of<PokeApi>(context, listen: false)
                          .fetchPokemonsByType(
                              StringAppContent.dragon.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.dragon,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            16
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          17
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            17
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 17;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.dark.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list = await Provider.of<PokeApi>(context,
                          listen: false)
                      .fetchPokemonsByType(StringAppContent.dark.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.dark,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            17
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02377,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    width * 0.3,
                    height * 0.0587,
                  ),
                  primary: Provider.of<ControllerPokemons>(context)
                              .setButtonSearchId ==
                          18
                      ? ThemeColor.primaryColor
                      : Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            18
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : ThemeColor.buttonSeeAll,
                  ),
                ),
                onPressed: () async {
                  Provider.of<ControllerPokemons>(context, listen: false)
                      .setButtonSearchId = 18;

                  Provider.of<ControllerPokemons>(context, listen: false)
                      .nameType = StringAppContent.fairy.toLowerCase();

                  Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    {}
                  ];
                  Provider.of<PokeApi>(context, listen: false).offset = 20;
                  List<PokemonDto> list =
                      await Provider.of<PokeApi>(context, listen: false)
                          .fetchPokemonsByType(
                              StringAppContent.fairy.toLowerCase());
                  Provider.of<PokeApi>(context, listen: false).getListPokemon(
                      list,
                      0,
                      Provider.of<UserManager>(context, listen: false).user.id);
                },
                child: Text(
                  StringAppContent.fairy,
                  style: TextStyle(
                    color: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            18
                        ? ThemeColor.stringButtonSignOut
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.stringGrey200
                            : ThemeColor.buttonSeeAll,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.01678,
                  ),
                ),
              ),
              Opacity(
                opacity: 0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      width * 0.3,
                      height * 0.0587,
                    ),
                    primary: Provider.of<ControllerPokemons>(context)
                                .setButtonSearchId ==
                            19
                        ? ThemeColor.primaryColor
                        : Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.backgourndColorDark
                            : Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        height * 0.0112,
                      ),
                    ),
                    side: BorderSide(
                      width: 1,
                      color: Provider.of<ControllerPokemons>(context)
                                  .setButtonSearchId ==
                              19
                          ? ThemeColor.primaryColor
                          : Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.white
                              : ThemeColor.buttonSeeAll,
                    ),
                  ),
                  onPressed: () async {
                    // Provider.of<ControllerPokemons>(context, listen: false)
                    //     .setButtonSearchId = 19;

                    // Provider.of<ControllerPokemons>(context, listen: false)
                    //     .nameType = StringAppContent.unknown.toLowerCase();

                    // Provider.of<PokeApi>(context, listen: false).listPokemon = [
                    //   {}
                    // ];
                    // Provider.of<PokeApi>(context, listen: false).offset = 20;
                    // List<PokemonDto> list =
                    //     await Provider.of<PokeApi>(context, listen: false)
                    //         .fetchPokemonsByType(
                    //             StringAppContent.unknown.toLowerCase());
                    // Provider.of<PokeApi>(context, listen: false)
                    //     .getListPokemon(list, 0;
                  },
                  child: Text(
                    StringAppContent.unknown,
                    style: TextStyle(
                      color: Provider.of<ControllerPokemons>(context)
                                  .setButtonSearchId ==
                              19
                          ? ThemeColor.stringButtonSignOut
                          : Provider.of<ThemeProvider>(context).isDarkMode
                              ? ThemeColor.stringGrey200
                              : ThemeColor.buttonSeeAll,
                      fontWeight: FontWeight.w500,
                      fontSize: height * 0.01678,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
