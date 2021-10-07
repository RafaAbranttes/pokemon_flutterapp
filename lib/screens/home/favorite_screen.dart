import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokemonapp/appcontent/string_appcontent.dart';
import 'package:pokemonapp/appcontent/theme.dart';
import 'package:pokemonapp/appcontent/theme_color.dart';
import 'package:pokemonapp/models/user_manager.dart';
import 'package:pokemonapp/screens/home/widgets/card_pokemon.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  TabController _tabController;

  FavoriteScreen(
    this._tabController,
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(Provider.of<UserManager>(context, listen: false).user.id)
            .collection("favorite")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: ThemeColor.primaryColor,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            List<DocumentSnapshot> documents = snapshot.data.docs;

            if (documents.isEmpty) {
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: width * 0.015,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.3497,
                      width: width,
                      child: Image.asset(
                        "assets/images/person.png",
                        fit: BoxFit.cover,
                        height: height * 0.3497,
                        width: width,
                      ),
                    ),
                    Container(
                      width: width,
                      alignment: Alignment.center,
                      child: Text(
                        StringAppContent.estaMeioVazioPorAqui,
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? ThemeColor.primaryColor
                              : ThemeColor.stringGrey500,
                          fontSize: height * 0.0336,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      width: width - (width * 0.12267),
                      alignment: Alignment.center,
                      child: Text(
                        StringAppContent.procurePorPokemonPara,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColor.stringGrey300,
                          fontSize: height * 0.01958,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04476,
                    ),
                    SizedBox(
                      height: height * 0.06294,
                      width: width * 0.62133,
                      child: ElevatedButton(
                        onPressed: () {
                          _tabController.animateTo(1);
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              Provider.of<ThemeProvider>(context).isDarkMode
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
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? ThemeColor.primaryColor
                                    : ThemeColor.buttonThemeDark,
                          ),
                        ),
                        child: Text(
                          StringAppContent.procurarPokemon,
                          style: TextStyle(
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? ThemeColor.primaryColor
                                    : ThemeColor.stringGrey300,
                            fontSize: height * 0.01958,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.only(
                  bottom: height * 0.112,
                  left: width * 0.064,
                  right: width * 0.064,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.02, vertical: height * 0.03),
                      child: Text(
                        snapshot.data.size == 1
                            ? "Olá, você tem ${snapshot.data.size}" +
                                " pokémon " +
                                "salvo!"
                            : "Olá, você tem ${snapshot.data.size}" +
                                " pokémons " +
                                "salvo!",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? ThemeColor.primaryColor
                              : ThemeColor.stringButtonSignOut,
                          fontSize: height * 0.0251,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: GridView.count(
                          childAspectRatio: (3 / 4),
                          crossAxisCount: 2,
                          children: List.generate(
                            snapshot.data.size,
                            (index) {
                              return StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(Provider.of<UserManager>(context,
                                            listen: false)
                                        .user
                                        .id)
                                    .collection("favorite")
                                    .doc(documents[index]["id"])
                                    .collection("types")
                                    .snapshots(),
                                builder: (context, snapshotcolletion) {
                                  if (snapshotcolletion.hasData) {
                                    List<DocumentSnapshot> document =
                                        snapshotcolletion.data.docs;
                                    List<String> type = [];
                                    for (var item in document) {
                                      type.add(item.id);
                                    }

                                    return cardPokemon(
                                        context: context,
                                        height: height,
                                        width: width,
                                        pokemon: {
                                          'id': documents[index]["id"],
                                          'name': documents[index]
                                              ["namePokemon"],
                                          'type': type,
                                          'image': documents[index]["image"],
                                          'image2': documents[index]["image2"],
                                          'attack': documents[index]["attack"],
                                          'defense': documents[index]
                                              ["defense"],
                                          'height': documents[index]["height"],
                                          'weight': documents[index]["weight"],
                                          'hp': documents[index]["hp"],
                                          'special_attack': documents[index]
                                              ["special_attack"],
                                          'special_defence': documents[index]
                                              ["special_defence"],
                                          'speed': documents[index]["speed"],
                                        }
                                        // pokemon: Provider.of<PokeApi>(context, listen: false)
                                        //     .listPokemonFavorite[index + 1],
                                        );
                                  } else {
                                    return Center(
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(
                                          color: ThemeColor.primaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                              // return Container();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.015,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.3497,
                    width: width,
                    child: Image.asset(
                      "assets/images/person.png",
                      fit: BoxFit.cover,
                      height: height * 0.3497,
                      width: width,
                    ),
                  ),
                  Container(
                    width: width,
                    alignment: Alignment.center,
                    child: Text(
                      StringAppContent.estaMeioVazioPorAqui,
                      style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? ThemeColor.primaryColor
                            : ThemeColor.stringGrey500,
                        fontSize: height * 0.0336,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: width - (width * 0.12267),
                    alignment: Alignment.center,
                    child: Text(
                      StringAppContent.procurePorPokemonPara,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColor.stringGrey300,
                        fontSize: height * 0.01958,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04476,
                  ),
                  SizedBox(
                    height: height * 0.06294,
                    width: width * 0.62133,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Provider.of<ThemeProvider>(context).isDarkMode
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
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? ThemeColor.primaryColor
                              : ThemeColor.buttonThemeDark,
                        ),
                      ),
                      child: Text(
                        StringAppContent.procurarPokemon,
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? ThemeColor.primaryColor
                              : ThemeColor.stringGrey300,
                          fontSize: height * 0.01958,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
