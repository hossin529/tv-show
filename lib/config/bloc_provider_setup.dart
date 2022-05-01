import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/logic/home/home_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<HomeBloc>(
    create: (BuildContext context) => HomeBloc(),
  )
];
