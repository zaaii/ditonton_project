part of 'serialtv_nowplaying_bloc.dart';

abstract class NowPlayingSerialTvEvent extends Equatable {
  const NowPlayingSerialTvEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingSerialTv extends NowPlayingSerialTvEvent {}