import 'package:flutter/material.dart';
import 'package:pokemonapp/api/poke_api.dart';
import 'package:pokemonapp/appcontent/string_appcontent.dart';
import 'package:pokemonapp/appcontent/theme.dart';
import 'package:pokemonapp/appcontent/theme_color.dart';
import 'package:pokemonapp/screens/home/widgets/card_pokemon.dart';
import 'package:provider/provider.dart';

class SearchSreen extends StatefulWidget {
  @override
  _SearchSreenState createState() => _SearchSreenState();
}

class _SearchSreenState extends State<SearchSreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.064,
          vertical: height * 0.064,
        ),
        child: Column(
          children: [
            Container(
              height: height * 0.0755,
              child: TextFormField(
                textInputAction: TextInputAction.next,
                autocorrect: false,
                controller: textEditingController,
                cursorColor: ThemeColor.primaryColor,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      Provider.of<PokeApi>(context, listen: false)
                          .searchPokemonByName(textEditingController.text);
                    },
                    icon: Icon(
                      Icons.search,
                      color: !Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.stringGrey300
                          : Colors.white,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: !Provider.of<ThemeProvider>(context).isDarkMode
                        ? ThemeColor.stringGrey300
                        : Colors.white,
                  ),
                  hintText: StringAppContent.procurePorPokemons,
                  hintStyle: TextStyle(
                    color: !Provider.of<ThemeProvider>(context).isDarkMode
                        ? ThemeColor.stringGrey300
                        : Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                    borderSide: BorderSide(
                      color: !Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.stringGrey300
                          : Colors.white,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      height * 0.0112,
                    ),
                    borderSide: BorderSide(
                      color: !Provider.of<ThemeProvider>(context).isDarkMode
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
                      color: ThemeColor.containerFavorite,
                      width: 1,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: !Provider.of<ThemeProvider>(context).isDarkMode
                      ? ThemeColor.stringGrey300
                      : Colors.white,
                  fontSize: height * 0.0168,
                ),
              ),
            ),
            Provider.of<PokeApi>(context).loadingSearch
                ? Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          color: ThemeColor.primaryColor,
                        ),
                      ),
                    ),
                  )
                : Provider.of<PokeApi>(context).error
                    ? Expanded(
                        child: Center(
                          child: Text(
                            StringAppContent.pokemonNaoEncontrado,
                          ),
                        ),
                      )
                    : Provider.of<PokeApi>(context).listPokemonSearch.length ==
                            1
                        ? Container()
                        : Expanded(
                            child: Container(
                              child: GridView.count(
                                childAspectRatio: (3 / 4),
                                crossAxisCount: 2,
                                children: List.generate(
                                  Provider.of<PokeApi>(context)
                                          .listPokemonSearch
                                          .length -
                                      1,
                                  (index) {
                                    return cardPokemon(
                                      context: context,
                                      height: height,
                                      width: width,
                                      pokemon: Provider.of<PokeApi>(context,
                                              listen: false)
                                          .listPokemonSearch[index + 1],
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
          ],
        ),
      ),
    );
  }
}
