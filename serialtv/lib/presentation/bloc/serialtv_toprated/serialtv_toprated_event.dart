part of 'serialtv_toprated_bloc.dart';

abstract class SerialTvTopRatedEvent extends Equatable {
  const SerialTvTopRatedEvent();

  @override
  List<Object> get props => [];
}

class FetchSerialTvTopRated extends SerialTvTopRatedEvent {}