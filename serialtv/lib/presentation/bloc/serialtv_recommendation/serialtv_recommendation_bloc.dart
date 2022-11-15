import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/usecases/get_serialtv_recommendations.dart';

part 'serialtv_recommendation_event.dart';
part 'serialtv_recommendation_state.dart';

class RecommendationsSerialTvBloc extends Bloc<RecommendationsSerialTvEvent, RecommendationsSerialTvState> {
  final GetRecommendationsSerialTv _getRecommendationsSerialTv;

  RecommendationsSerialTvBloc(this._getRecommendationsSerialTv) : super(RecommendationsSerialTvEmpty()) {
    on<FetchRecommendationsSerialTv>((event, emit) async {
        emit(RecommendationsSerialTvLoading());
        final serialTvRecommendationsResult = await _getRecommendationsSerialTv.execute(event.id);

        serialTvRecommendationsResult.fold(
              (failure) => emit(RecommendationsSerialTvError(failure.message)),
              (data) => emit(RecommendationsSerialTvHasData(data))
        );
      },
    );
  }
}