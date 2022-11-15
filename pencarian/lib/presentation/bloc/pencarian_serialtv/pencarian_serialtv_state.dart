part of 'pencarian_serialtv_bloc.dart';

abstract class SearchSerialTvState extends Equatable {
  const SearchSerialTvState();

  @override
  List<Object> get props => [];
}

class SearchSerialTvLoading extends SearchSerialTvState {}

class SearchSerialTvEmpty extends SearchSerialTvState {}

class SearchSerialTvError extends SearchSerialTvState {
  final String message;
  const SearchSerialTvError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchSerialTvHasData extends SearchSerialTvState {
  final List<SerialTv> serialtvresult;

  SearchSerialTvHasData(this.serialtvresult);

  @override
  List<Object> get props => [serialtvresult];
}