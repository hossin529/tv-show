import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/logic/favorite/favorite_bloc.dart';
import 'package:tv_shows/logic/home/home_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<HomeBloc>(
    create: (BuildContext context) => HomeBloc(),
  ),
  BlocProvider<FavoriteBloc>(
    create: (BuildContext context) => FavoriteBloc()..add(const InitFavorite()),
  ),
];
