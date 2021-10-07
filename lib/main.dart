import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemonapp/api/poke_api.dart';
import 'package:pokemonapp/appcontent/theme.dart';
import 'package:pokemonapp/appcontent/theme_color.dart';
import 'package:pokemonapp/models/user_manager.dart';
import 'package:pokemonapp/screens/detail/pokemon_detail.dart';
import 'package:pokemonapp/screens/home/controller/controller_pokemons.dart';
import 'package:pokemonapp/screens/home/home_sreen.dart';
import 'package:pokemonapp/screens/initial_screen/initial_screen.dart';
import 'package:pokemonapp/screens/login/controller/login_signup_controller.dart';
import 'package:pokemonapp/screens/login/login_screen.dart';
import 'package:pokemonapp/screens/login/signup_screen.dart';
import 'package:pokemonapp/screens/routes/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: ThemeColor.primaryColor,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => loginController(),
        ),
        ChangeNotifierProvider(
          create: (_) => signUpController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ControllerPokemons(),
        ),
        ChangeNotifierProvider(
          create: (_) => PokeApi(),
        ),
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        Provider.of<loginController>(context, listen: false).resetData();
        Provider.of<signUpController>(context, listen: false).resetData();
        return MaterialApp(
          title: 'Pokémon',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          darkTheme: MyThemes.darkTheme,
          theme: MyThemes.lightTheme,
          routes: {
            Routes.INITIAL_SCREEN: (context) => InitialScreen(),
            Routes.LOGIN_SCREEN: (context) => LoginScreen(),
            Routes.HOME_SCREEN: (context) => HomeScreen(),
            Routes.REGISTER_SCREEN: (context) => SignUpScreen(),
            Routes.DETAIL_POKEMON: (context) => PokemonDetail(
                  ModalRoute.of(context).settings.arguments,
                ),
          },
        );
      },
    );
  }
}
