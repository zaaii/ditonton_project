import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/usecases/get_serialtv_toprated.dart';

part 'serialtv_toprated_event.dart';
part 'serialtv_toprated_state.dart';

class SerialTvTopRatedBloc extends Bloc<SerialTvTopRatedEvent, SerialTvTopRatedState> {
  final GetSerialTvTopRated _getSerialTvTopRated;

  SerialTvTopRatedBloc(this._getSerialTvTopRated) : super(SerialTvTopRatedEmpty()) {
    on<FetchSerialTvTopRated>((event, emit) async {
        emit(SerialTvTopRatedLoading());
        final serialTvTopRatedResult = await _getSerialTvTopRated.execute();

        serialTvTopRatedResult.fold(
              (failure) => emit(SerialTvTopRatedError(failure.message)),
              (serialtvdata) => emit(SerialTvTopRatedHasData(serialtvdata))
        );
      },
    );
  }
}