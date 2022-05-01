import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/logic/home/home_bloc.dart';
import 'package:tv_shows/ui/screens/favorite/favorite_screen.dart';
import 'package:tv_shows/ui/utils/dialogs.dart';
import 'package:tv_shows/ui/utils/util.dart';
import 'package:tv_shows/ui/widgets/cards/tv_show_card.dart';
import 'package:tv_shows/ui/widgets/loader/bottom_loader.dart';
import 'package:tv_shows/ui/widgets/no_result.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = new ScrollController();
  TextEditingController _searchEditingController = new TextEditingController();
  Timer? searchOnStoppedTyping;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);

    BlocProvider.of<HomeBloc>(context).add(const InitHome());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll == currentScroll) {
      BlocProvider.of<HomeBloc>(context).add(const LoadHome());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<HomeBloc, HomeState>(listener: (context, state) {
      if (state.status == HomeStatus.error) {
        Dialogs.showFlushBar(context, state.message ?? 'Error', type: 'danger');
      }

      return;
    }, child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  controller: _searchEditingController,
                  onChanged: (val) {
                    if (val.isEmpty) return;
                    const duration = Duration(milliseconds: 800);
                    if (searchOnStoppedTyping != null) {
                      searchOnStoppedTyping?.cancel(); // clear timer
                    }
                    searchOnStoppedTyping = Timer(duration, () {
                      FocusScope.of(context).requestFocus(FocusNode());

                      BlocProvider.of<HomeBloc>(context).add(
                          SearchHome(_searchEditingController.text.trim()));
                    });
                  },
                  onEditingComplete: () {
                    if (_searchEditingController.text.trim().isEmpty) return;
                    FocusScope.of(context).requestFocus(FocusNode());

                    BlocProvider.of<HomeBloc>(context)
                        .add(SearchHome(_searchEditingController.text.trim()));
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: _searchEditingController.text.isNotEmpty
                            ? const Icon(Icons.clear)
                            : Container(),
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(const InitHome());
                          _searchEditingController.clear();
                        },
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                ),
              ),
            ),
            leading: null,
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () =>
                    Navigator.of(context).pushNamed(FavoriteScreen.routeName),
              ),
            ],
          ),
          body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state.status == HomeStatus.loading && state.tvShows.isEmpty) {
              return Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                child: const CircularProgressIndicator(),
              );
            }
            return state.tvShows.isEmpty
                ? NoResult(
                    onTap: () {
                      BlocProvider.of<HomeBloc>(context).add(const InitHome());
                      _searchEditingController.clear();
                    },
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical!,
                        horizontal: SizeConfig.paddingHorizontal!),
                    itemCount: state.hasReachedMax
                        ? state.tvShows.length
                        : state.tvShows.length + 1,
                    itemBuilder: (context, index) =>
                        index >= state.tvShows.length
                            ? BottomLoader()
                            : TvShowCard(
                                tvShow: state.tvShows[index],
                              ));
          }));
    }));
  }
}
