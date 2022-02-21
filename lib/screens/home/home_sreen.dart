import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokemonapp/api/poke_api.dart';
import 'package:pokemonapp/appcontent/string_appcontent.dart';
import 'package:pokemonapp/appcontent/theme.dart';
import 'package:pokemonapp/appcontent/theme_color.dart';
import 'package:pokemonapp/models/user_manager.dart';
import 'package:pokemonapp/screens/home/controller/controller_pokemons.dart';
import 'package:pokemonapp/screens/home/favorite_screen.dart';
import 'package:pokemonapp/screens/home/search_screen.dart';
import 'package:pokemonapp/screens/home/see_all_screen.dart';
import 'package:pokemonapp/screens/widgets/footer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    initial();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 3,
    );
  }

  void initial() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<ControllerPokemons>(context, listen: false)
            .setButtonSearchId = 0;
        Provider.of<ControllerPokemons>(context, listen: false).nameType =
            StringAppContent.todos.toLowerCase();

        Provider.of<PokeApi>(context, listen: false).listPokemon = [{}];
        Provider.of<PokeApi>(context, listen: false).offsetAll = 0;

        Provider.of<PokeApi>(context, listen: false).getListPokemonAll(
          0,
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: Container(
                    height: height * 0.2,
                    color: Provider.of<ThemeProvider>(context).isDarkMode
                        ? ThemeColor.appBarColorDark
                        : ThemeColor.primaryColor,
                    child: Center(
                        child: Image.asset("assets/images/pokemon_appbar.png")),
                  ),
                  centerTitle: true,
                  titleSpacing: 0,
                  floating: true,
                  snap: false,
                  pinned: false,
                  backgroundColor:
                      Provider.of<ThemeProvider>(context).isDarkMode
                          ? ThemeColor.backgourndColorDark
                          : Colors.white,
                  bottom: PreferredSize(
                    preferredSize: Size(20, kToolbarHeight),
                    child: _tabBar(
                      context,
                      height,
                      width,
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                FavoriteScreen(_tabController),
                SearchSreen(),
                SeeAllScreen(), // use MyScreen3()
              ],
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
          Container(
            child: footerApp(
              isLogin: false,
              context: context,
              height: height,
              width: width,
              appBar: false,
            ),
          ),
          // Positioned(
          //   top: 0.0,
          //   left: 0.0,
          //   right: 0.0,
          //   child: Container(
          //     child: SafeArea(
          //       top: false,
          //       child: appBar(context),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  TabBar _tabBar(BuildContext context, double height, double width) {
    return TabBar(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.0,
          color: Provider.of<ThemeProvider>(context).isDarkMode
              ? ThemeColor.stringGrey200
              : ThemeColor.stringGrey500,
        ),
        insets: EdgeInsets.symmetric(
          horizontal: width * 0.06,
        ),
      ),
      controller: _tabController,
      indicatorColor: Provider.of<ThemeProvider>(context).isDarkMode
          ? ThemeColor.stringGrey200
          : ThemeColor.stringGrey500,
      labelColor: Provider.of<ThemeProvider>(context).isDarkMode
          ? ThemeColor.stringGrey200
          : ThemeColor.stringGrey500,
      tabs: [
        Tab(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringAppContent.favorito,
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Container(
                  height: height * 0.022,
                  width: height * 0.022,
                  decoration: BoxDecoration(
                    color: Provider.of<ThemeProvider>(context).isDarkMode
                        ? ThemeColor.stringGrey300
                        : ThemeColor.stringButtonSignOut,
                    borderRadius: BorderRadius.all(
                      Radius.circular(90),
                    ),
                  ),
                  child: Center(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(Provider.of<UserManager>(context, listen: false)
                              .user
                              .id)
                          .collection("favorite")
                          .snapshots(),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.hasData
                              ? snapshot.data.size.toString()
                              : "0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: height * 0.015,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Tab(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              StringAppContent.procurar,
            ),
          ),
        ),
        Tab(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              StringAppContent.verTodos,
            ),
          ),
        ),
      ],
    );
  }
}
