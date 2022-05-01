import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/logic/favorite/favorite_bloc.dart';
import 'package:tv_shows/ui/utils/dialogs.dart';
import 'package:tv_shows/ui/utils/util.dart';
import 'package:tv_shows/ui/widgets/cards/tv_show_card.dart';
import 'package:tv_shows/ui/widgets/no_result.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = 'Favorite';
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    BlocProvider.of<FavoriteBloc>(context).add(const InitFavorite());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
      if (state.status == FavoriteStatus.error) {
        Dialogs.showFlushBar(context, state.message ?? 'Error', type: 'danger');
      }

      return;
    }, child:
            BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
      if (state.status == FavoriteStatus.loading && state.tvShows.isEmpty) {
        return Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          child: const CircularProgressIndicator(),
        );
      }
      return Scaffold(
          appBar: AppBar(
            title: const Text('Favorite'),
          ),
          body: state.tvShows.isEmpty
              ? NoResult(
                  onTap: () {
                    BlocProvider.of<FavoriteBloc>(context)
                        .add(const InitFavorite());
                  },
                )
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical!,
                      horizontal: SizeConfig.paddingHorizontal!),
                  itemCount: state.tvShows.length,
                  itemBuilder: (context, index) => TvShowCard(
                        tvShow: state.tvShows[index],
                      )));
    }));
  }
}
