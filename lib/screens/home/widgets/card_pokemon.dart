import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokemonapp/api/poke_api.dart';
import 'package:pokemonapp/appcontent/string_appcontent.dart';
import 'package:pokemonapp/appcontent/theme.dart';
import 'package:pokemonapp/appcontent/theme_color.dart';
import 'package:pokemonapp/models/user_manager.dart';
import 'package:pokemonapp/screens/detail/arguments/pokemon_detail_arguments.dart';
import 'package:pokemonapp/screens/routes/routes.dart';
import 'package:provider/provider.dart';

Widget cardPokemon({
  double height,
  double width,
  BuildContext context,
  Map<String, dynamic> pokemon,
}) {

  bool isFavorite = false;

  return Container(
    width: width * 0.41068,
    height: height * 0.3536,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          width * 0.01868,
        ),
      ),
      elevation: 3,
      child: Container(
        margin: EdgeInsets.only(
          bottom: height * 0.0208,
          top: height * 0.0192,
          left: width * 0.0213,
          right: width * 0.0213,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: height * 0.089,
                      child: Image.network(
                        pokemon["image"],
                        fit: BoxFit.cover,
                        height: height * 0.089,
                      ),
                    ),
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(Provider.of<UserManager>(context, listen: false)
                            .user
                            .id)
                        .collection("favorite")
                        .doc(pokemon["id"])
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.exists) {
                          isFavorite = true;
                          return Container(
                            alignment: Alignment.topRight,
                            height: height * 0.089,
                            child: IconButton(
                              onPressed: () {
                                Provider.of<PokeApi>(context, listen: false)
                                    .deleteFavorite(
                                  Provider.of<UserManager>(context,
                                          listen: false)
                                      .user
                                      .id,
                                  pokemon["id"],
                                  pokemon["type"],
                                );
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: ThemeColor.containerFavorite,
                                size: width * 0.064,
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            alignment: Alignment.topRight,
                            height: height * 0.089,
                            child: IconButton(
                              onPressed: () {
                                Provider.of<PokeApi>(context, listen: false)
                                    .setFavorite(
                                  userId: Provider.of<UserManager>(context,
                                          listen: false)
                                      .user
                                      .id,
                                  idPokemon: pokemon["id"],
                                  namePokemon: pokemon["name"],
                                  url: pokemon["image"],
                                  url2 : pokemon["image2"],
                                  type: pokemon["type"],
                                  attack: pokemon["attack"],
                                  defense: pokemon["defense"],
                                  height: pokemon["height"],
                                  weight: pokemon["weight"],
                                  hp: pokemon["hp"],
                                  specialAttack: pokemon["special_attack"],
                                  specialDefence: pokemon["special_defence"],
                                  speed: pokemon["speed"],
                                );
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                color: ThemeColor.stringGrey300,
                                size: width * 0.064,
                              ),
                            ),
                          );
                        }
                      } else {
                        return Container(
                          alignment: Alignment.topRight,
                          height: height * 0.089,
                          child: IconButton(
                            onPressed: () {
                              Provider.of<PokeApi>(context, listen: false)
                                  .setFavorite(
                                userId: Provider.of<UserManager>(context,
                                        listen: false)
                                    .user
                                    .id,
                                idPokemon: pokemon["id"],
                                namePokemon: pokemon["name"],
                                url: pokemon["image"],
                                url2: pokemon["image2"],
                                type: pokemon["type"],
                                attack: pokemon["attack"],
                                defense: pokemon["defense"],
                                height: pokemon["height"],
                                weight: pokemon["weight"],
                                hp: pokemon["hp"],
                                specialAttack: pokemon["special_attack"],
                                specialDefence: pokemon["special_defence"],
                                speed: pokemon["speed"],
                              );
                            },
                            icon: Icon(
                              Icons.favorite_border,
                              color: ThemeColor.containerFavorite,
                              size: width * 0.064,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: width * 0.01,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                pokemon["name"][0].toString().toUpperCase() +
                    pokemon["name"]
                        .toString()
                        .substring(1, pokemon["name"].toString().length),
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? ThemeColor.primaryColor
                      : Colors.black,
                  fontSize: height * 0.0224,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: width * 0.01,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                "ID: ${pokemon["id"]}",
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? ThemeColor.stringGrey200
                      : ThemeColor.idColor,
                  fontSize: height * 0.0168,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: height * 0.03,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pokemon["type"].length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        left: width * 0.01,
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
                      child: Text(
                        pokemon["type"][index],
                        style: TextStyle(
                          color: index == 0
                              ? ThemeColor.stringGrey500
                              : Colors.white,
                          fontSize: height * 0.015,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: height * 0.007,
            ),
            SizedBox(
              width: width * 0.36535,
              height: height * 0.04641,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ThemeColor.primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      width * 0.01868,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Routes.DETAIL_POKEMON,
                    arguments: PokemonDetailArguments(
                      isFavorite: isFavorite,
                      id: pokemon["id"],
                      namePokemon: pokemon["name"],
                      url: pokemon["image"],
                      url2: pokemon['image2'],
                      type: pokemon["type"],
                      attack: pokemon["attack"],
                      defense: pokemon["defense"],
                      height: pokemon["height"],
                      weight: pokemon["weight"],
                      hp: pokemon["hp"],
                      specialAttack: pokemon["special_attack"],
                      specialDefence: pokemon["special_defence"],
                      speed: pokemon["speed"],
                    ),
                  );
                },
                child: Text(
                  StringAppContent.verDetalhes,
                  style: TextStyle(
                    color: ThemeColor.stringButtonSignOut,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
