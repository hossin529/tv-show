import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_shows/data/models/tv_show.dart';
import 'package:tv_shows/data/repositories/favorite_repository.dart';

part "favorite_event.dart";
part "favorite_state.dart";

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const FavoriteState()) {
    on<InitFavorite>(_onInitFavorite);
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
  }
  final favoriteRepository _repository = favoriteRepository();

  Future<void> _onInitFavorite(
      InitFavorite event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    try {
      final tvShows = await _repository.getFavorits();

      emit(FavoriteState(status: FavoriteStatus.loaded, tvShows: tvShows));
    } catch (e) {
      emit(state.copyWith(
          status: FavoriteStatus.error, message: e.toString(), tvShows: []));
    }
  }

  Future<void> _onAddFavorite(
      AddFavorite event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    try {
      await _repository.addFavorite(event.tvShow);
      final tvShows = await _repository.getFavorits();

      emit(state.copyWith(status: FavoriteStatus.loaded, tvShows: tvShows));
    } catch (e) {
      emit(state.copyWith(status: FavoriteStatus.error, message: e.toString()));
    }
  }

  Future<void> _onRemoveFavorite(
      RemoveFavorite event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    try {
      await _repository.removeFavorite(event.tvShow);
      final tvShows = await _repository.getFavorits();

      emit(state.copyWith(status: FavoriteStatus.loaded, tvShows: tvShows));
    } catch (e) {
      emit(state.copyWith(status: FavoriteStatus.error, message: e.toString()));
    }
  }
}
