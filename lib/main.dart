import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/config/router.dart' as router;
import 'package:tv_shows/config/bloc_provider_setup.dart';
import 'package:tv_shows/ui/utils/util.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      // ignore: prefer_const_constructors
      child: MaterialApp(
        title: AppConfig.appName,
        onGenerateRoute: router.Router.generateRoute,
        initialRoute: router.initialRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
