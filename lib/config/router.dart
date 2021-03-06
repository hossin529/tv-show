import 'package:flutter/material.dart';
import 'package:tv_shows/ui/screens/favorite/favorite_screen.dart';
import 'package:tv_shows/ui/screens/home/home_screen.dart';

const String initialRoute = HomeScreen.routeName;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case FavoriteScreen.routeName:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
