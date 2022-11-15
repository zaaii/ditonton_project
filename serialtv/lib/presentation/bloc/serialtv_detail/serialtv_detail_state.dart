part of 'serialtv_detail_bloc.dart';

abstract class DetailSerialTvState extends Equatable {
  const DetailSerialTvState();

  @override
  List<Object> get props => [];
}

class DetailSerialTvLoading extends DetailSerialTvState {}

class DetailSerialTvEmpty extends DetailSerialTvState {}

class DetailSerialTvError extends DetailSerialTvState {
  final String message;
  const DetailSerialTvError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailSerialTvHasData extends DetailSerialTvState {
  final DetailSerialTv result;

  const DetailSerialTvHasData(this.result);

  @override
  List<Object> get props => [result];
}