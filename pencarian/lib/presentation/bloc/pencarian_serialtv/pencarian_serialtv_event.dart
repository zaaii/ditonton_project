part of 'pencarian_serialtv_bloc.dart';

abstract class SearchSerialTvEvent extends Equatable {
  const SearchSerialTvEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedSerialTv extends SearchSerialTvEvent {
  final String query;
  const OnQueryChangedSerialTv(this.query);

  @override
  List<Object> get props => [query];
}