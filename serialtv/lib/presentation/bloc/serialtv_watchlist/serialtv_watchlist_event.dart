part of 'serialtv_watchlist_bloc.dart';

abstract class WatchlistSerialTvEvent extends Equatable {
  const WatchlistSerialTvEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistSerialTv extends WatchlistSerialTvEvent {}

class LoadWatchListStatusSerialTv extends WatchlistSerialTvEvent {
  final int id;
  const LoadWatchListStatusSerialTv(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlistSerialTv extends WatchlistSerialTvEvent {
  final DetailSerialTv serialtv;

  const AddWatchlistSerialTv(this.serialtv);

  @override
  List<Object> get props => [serialtv];
}

class DeleteWatchlistSerialTv extends WatchlistSerialTvEvent {
  final DetailSerialTv serialtv;
  const DeleteWatchlistSerialTv(this.serialtv);

  @override
  List<Object> get props => [serialtv];
}