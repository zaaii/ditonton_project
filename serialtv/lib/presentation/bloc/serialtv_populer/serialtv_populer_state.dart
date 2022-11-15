part of 'serialtv_populer_bloc.dart';

abstract class SerialTvPopulerState extends Equatable {
  const SerialTvPopulerState();

  @override
  List<Object> get props => [];
}

class SerialTvPopulerEmpty extends SerialTvPopulerState {}

class SerialTvPopulerLoading extends SerialTvPopulerState {}

class SerialTvPopulerError extends SerialTvPopulerState {
  final String message;
  const SerialTvPopulerError(this.message);

  @override
  List<Object> get props => [message];
}

class SerialTvPopulerHasData extends SerialTvPopulerState {
  final List<SerialTv> result;
  const SerialTvPopulerHasData(this.result);

  @override
  List<Object> get props => [result];
}