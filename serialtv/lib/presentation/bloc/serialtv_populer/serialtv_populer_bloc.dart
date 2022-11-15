import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/usecases/get_serialtv_populer.dart';

part 'serialtv_populer_event.dart';
part 'serialtv_populer_state.dart';

class SerialTvPopulerBloc extends Bloc<SerialTvPopulerEvent, SerialTvPopulerState> {
  final GetSerialTvPopuler _getSerialTvPopuler;

  SerialTvPopulerBloc(this._getSerialTvPopuler) : super(SerialTvPopulerEmpty()) {
    on<FetchSerialTvPopuler>((event, emit) async {
        emit(SerialTvPopulerLoading());
        final serialTvPopulerResult = await _getSerialTvPopuler.execute();

        serialTvPopulerResult.fold(
              (failure) => emit(SerialTvPopulerError(failure.message)),
              (data) => emit(SerialTvPopulerHasData(data))
        );
      },
    );
  }
}