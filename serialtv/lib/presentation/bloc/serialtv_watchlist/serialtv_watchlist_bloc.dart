import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/entities/serialtv_detail.dart';
import 'package:serialtv/domain/usecases/get_serialtv_watchlist_status.dart';
import 'package:serialtv/domain/usecases/get_serialtv_watchlist.dart';
import 'package:serialtv/domain/usecases/remove_serialtv_watchlist.dart';
import 'package:serialtv/domain/usecases/save_serialtv_watchlist.dart';

part 'serialtv_watchlist_event.dart';
part 'serialtv_watchlist_state.dart';

class WatchlistSerialTvBloc extends Bloc<WatchlistSerialTvEvent, WatchlistSerialTvState> {
  final GetWatchlistSerialTv _getWatchlistSerialTv;
  final GetWatchListStatusSerialTv _getWatchListStatusSerialTv;
  final SaveWatchlistSerialTv _saveWatchlistSerialTv;
  final RemoveWatchlistSerialTv _removeWatchlistSerialTv;

  WatchlistSerialTvBloc(this._getWatchlistSerialTv, this._getWatchListStatusSerialTv, this._saveWatchlistSerialTv, this._removeWatchlistSerialTv) : super(WatchlistSerialTvEmpty()) {
    on<LoadWatchlistSerialTv>((event, emit) async {
        emit(WatchlistSerialTvLoading());
        final watchlistSerialTvResult = await _getWatchlistSerialTv.execute();

        watchlistSerialTvResult.fold(
              (failure) => emit(WatchlistSerialTvError(failure.message)),
              (data) => emit(WatchlistSerialTvHasData(data))
        );
      },
    );

    on<LoadWatchListStatusSerialTv>(((event, emit) async {
      final watchlistSerialTvresult = await _getWatchListStatusSerialTv.execute(event.id);

      emit(WatchlistSerialTvStatus(watchlistSerialTvresult));
    }));

    on<AddWatchlistSerialTv>((event, emit) async {
      final watchlistSerialTvresult = await _saveWatchlistSerialTv.execute(event.serialtv);

      watchlistSerialTvresult.fold(
              (failure) => emit(WatchlistSerialTvError(failure.message)),
              (successNotif) => emit(WatchlistSerialTvMessage('Serial Tv ditambahkan ke Watchlist'))
      );

      add(LoadWatchListStatusSerialTv(event.serialtv.id));
    });

    on<DeleteWatchlistSerialTv>((event, emit) async {
      final watchlistSerialTvresult = await _removeWatchlistSerialTv.execute(event.serialtv);

      watchlistSerialTvresult.fold(
              (failure) => emit(WatchlistSerialTvError(failure.message)),
              (successNotif) => emit(WatchlistSerialTvMessage('Serial Tv dihapus dari Watchlist'))
      );

      add(LoadWatchListStatusSerialTv(event.serialtv.id));
    });
  }
}