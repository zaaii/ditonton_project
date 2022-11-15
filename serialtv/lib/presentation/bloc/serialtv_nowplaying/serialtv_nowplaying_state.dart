part of 'serialtv_nowplaying_bloc.dart';

abstract class NowPlayingSerialTvState extends Equatable {
  const NowPlayingSerialTvState();

  @override
  List<Object> get props => [];
}

class NowPlayingSerialTvLoading extends NowPlayingSerialTvState {}

class NowPlayingSerialTvEmpty extends NowPlayingSerialTvState {}

class NowPlayingSerialTvError extends NowPlayingSerialTvState {
  final String message;

  const NowPlayingSerialTvError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingSerialTvHasData extends NowPlayingSerialTvState {
  final List<SerialTv> result;

  const NowPlayingSerialTvHasData(this.result);

  @override
  List<Object> get props => [result];
}