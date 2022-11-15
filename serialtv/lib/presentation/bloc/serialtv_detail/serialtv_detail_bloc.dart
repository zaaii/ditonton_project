import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serialtv_detail.dart';
import 'package:serialtv/domain/usecases/get_serialtv_detail.dart';

part 'serialtv_detail_event.dart';
part 'serialtv_detail_state.dart';

class DetailSerialTvBloc extends Bloc<DetailSerialTvEvent, DetailSerialTvState> {
  final GetDetailSerialTv _getDetailSerialTv;

  DetailSerialTvBloc(this._getDetailSerialTv) : super(DetailSerialTvEmpty()) {
    on<FetchDetailSerialTv>((event, emit) async {
        final id = event.id;

        emit(DetailSerialTvLoading());
        final detailSerialTvResult = await _getDetailSerialTv.execute(id);

        detailSerialTvResult.fold(
              (failure) => emit(DetailSerialTvError(failure.message)),
              (data) => emit(DetailSerialTvHasData(data))
        );
      },
    );
  }
}