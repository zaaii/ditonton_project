part of 'serialtv_recommendation_bloc.dart';

abstract class RecommendationsSerialTvState extends Equatable {
  const RecommendationsSerialTvState();

  @override
  List<Object> get props => [];
}

class RecommendationsSerialTvLoading extends RecommendationsSerialTvState {}

class RecommendationsSerialTvEmpty extends RecommendationsSerialTvState {}

class RecommendationsSerialTvError extends RecommendationsSerialTvState {
  final String message;
  const RecommendationsSerialTvError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationsSerialTvHasData extends RecommendationsSerialTvState {
  final List<SerialTv> result;
  const RecommendationsSerialTvHasData(this.result);

  @override
  List<Object> get props => [result];
}