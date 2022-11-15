part of 'serialtv_watchlist_bloc.dart';

abstract class WatchlistSerialTvState extends Equatable {
  const WatchlistSerialTvState();

  @override
  List<Object> get props => [];
}

class WatchlistSerialTvLoading extends WatchlistSerialTvState {}

class WatchlistSerialTvEmpty extends WatchlistSerialTvState {}

class WatchlistSerialTvError extends WatchlistSerialTvState {
  final String message;

  const WatchlistSerialTvError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistSerialTvHasData extends WatchlistSerialTvState {
  final List<SerialTv> result;

  const WatchlistSerialTvHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistError extends WatchlistSerialTvState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistSerialTvMessage extends WatchlistSerialTvState {
  final String message;

  const WatchlistSerialTvMessage(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistSerialTvStatus extends WatchlistSerialTvState {
  final bool isSerialTvAdded;

  const WatchlistSerialTvStatus(this.isSerialTvAdded);

  @override
  List<Object> get props => [isSerialTvAdded];
}