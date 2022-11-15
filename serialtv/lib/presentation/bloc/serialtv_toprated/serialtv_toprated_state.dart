part of 'serialtv_toprated_bloc.dart';

abstract class SerialTvTopRatedState extends Equatable {
  const SerialTvTopRatedState();

  @override
  List<Object> get props => [];
}

class SerialTvTopRatedLoading extends SerialTvTopRatedState {}

class SerialTvTopRatedEmpty extends SerialTvTopRatedState {}

class SerialTvTopRatedError extends SerialTvTopRatedState {
  final String message;

  const SerialTvTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class SerialTvTopRatedHasData extends SerialTvTopRatedState {
  final List<SerialTv> result;

  const SerialTvTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}