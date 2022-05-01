import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_shows/data/models/tv_show.dart';
import 'package:tv_shows/data/repositories/tv_show_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<InitHome>(_onInitHome);
    on<LoadHome>(_onLoadHome);
    on<SearchHome>(_onSearchHome);
  }

  final TvShowRepository _tvShowRepository = TvShowRepository();

  final int _perPage = 20;

  Future<void> _onInitHome(InitHome event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final tvShows = await _tvShowRepository.getHomeTvShows(page: 1);

      emit(HomeState(
          status: HomeStatus.loaded,
          tvShows: tvShows,
          hasReachedMax: tvShows.length < _perPage));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: HomeStatus.error, message: e.toString(), tvShows: []));
    }
  }

  Future<void> _onLoadHome(LoadHome event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    if (!state.hasReachedMax) {
      try {
        final tvShows = await _tvShowRepository.getHomeTvShows(
          page: ((state.tvShows.length / _perPage).round() + 1),
          search: state.search,
        );

        state.tvShows.addAll(tvShows);
        emit(state.copyWith(
            status: HomeStatus.loaded,
            tvShows: state.tvShows,
            hasReachedMax: tvShows.length < _perPage));
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(status: HomeStatus.error, message: e.toString()));
      }
    } else {
      emit(state.copyWith(status: HomeStatus.loaded));
    }
  }

  Future<void> _onSearchHome(SearchHome event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final tvShows =
          await _tvShowRepository.getHomeTvShows(page: 1, search: event.search);

      emit(state.copyWith(
          status: HomeStatus.loaded,
          tvShows: tvShows,
          search: event.search,
          hasReachedMax: tvShows.length < _perPage));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: HomeStatus.error, message: e.toString()));
    }
  }
}
