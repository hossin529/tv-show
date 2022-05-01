import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/data/models/tv_show.dart';
import 'package:tv_shows/logic/favorite/favorite_bloc.dart';

import '../../utils/util.dart';

class TvShowCard extends StatefulWidget {
  final TvShow? tvShow;
  const TvShowCard({
    Key? key,
    this.tvShow,
  }) : super(key: key);

  @override
  State<TvShowCard> createState() => _TvShowCardState();
}

class _TvShowCardState extends State<TvShowCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.paddingVertical!),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: Style.cardDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: widget.tvShow?.posterPath == null
                ? Container(
                    color: Style.placeHolderColor,
                    height: 150,
                    child: Center(
                        child: Icon(
                      Icons.image,
                      color: Style.primaryColor,
                    )),
                  )
                : Image.network(
                    '${widget.tvShow?.posterFullPath}',
                    // height: 100,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical!,
                      bottom: SizeConfig.blockSizeVertical!,
                      left: SizeConfig.blockSizeHorizontal! * 2,
                      right: SizeConfig.blockSizeHorizontal! * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Text(
                          '${widget.tvShow?.originalName}',
                          style: Style.largeTitleTextStyle,
                          maxLines: 2,
                        ),
                      ),
                      BlocBuilder<FavoriteBloc, FavoriteState>(
                          builder: (context, state) {
                        var tvShowfounded = state.tvShows.firstWhere(
                            (itemToCheck) =>
                                itemToCheck.id == widget.tvShow!.id,
                            orElse: () => TvShow());
                        if (state.status == FavoriteStatus.loading) {
                          return Container(
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            child: const CircularProgressIndicator(),
                          );
                        }
                        return tvShowfounded.id != null
                            ? IconButton(
                                color: Colors.redAccent,
                                icon: const Icon(Icons.favorite),
                                onPressed: () {
                                  BlocProvider.of<FavoriteBloc>(context)
                                      .add(RemoveFavorite(widget.tvShow!));
                                },
                              )
                            : IconButton(
                                color: Colors.redAccent,
                                icon: const Icon(Icons.favorite_border),
                                onPressed: () {
                                  BlocProvider.of<FavoriteBloc>(context)
                                      .add(AddFavorite(widget.tvShow!));
                                },
                              );
                      })
                    ],
                  ),
                ),

                Text('${widget.tvShow?.overview}'),
                // const SizedBox(height: 21),

                // const SizedBox(height: 21),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
