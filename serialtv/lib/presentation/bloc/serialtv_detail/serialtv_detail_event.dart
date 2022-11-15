part of 'serialtv_detail_bloc.dart';

abstract class DetailSerialTvEvent extends Equatable {
  const DetailSerialTvEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailSerialTv extends DetailSerialTvEvent {
  final int id;
  const FetchDetailSerialTv(this.id);

  @override
  List<Object> get props => [id];
}