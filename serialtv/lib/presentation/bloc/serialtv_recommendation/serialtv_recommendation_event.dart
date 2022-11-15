part of 'serialtv_recommendation_bloc.dart';

abstract class RecommendationsSerialTvEvent extends Equatable {
  const RecommendationsSerialTvEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendationsSerialTv extends RecommendationsSerialTvEvent {
  final int id;
  const FetchRecommendationsSerialTv(this.id);

  @override
  List<Object> get props => [id];
}