part of 'serialtv_populer_bloc.dart';

abstract class SerialTvPopulerEvent extends Equatable {
  const SerialTvPopulerEvent();

  @override
  List<Object> get props => [];
}

class FetchSerialTvPopuler extends SerialTvPopulerEvent {}