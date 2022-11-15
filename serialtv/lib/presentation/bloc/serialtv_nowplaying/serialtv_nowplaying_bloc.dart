import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/usecases/get_serialtv_now_playing.dart';

part 'serialtv_nowplaying_event.dart';
part 'serialtv_nowplaying_state.dart';

class NowPlayingSerialTvBloc extends Bloc<NowPlayingSerialTvEvent, NowPlayingSerialTvState> {
  final GetNowPlayingSerialTv _getNowPlayingSerialTv;

  NowPlayingSerialTvBloc(this._getNowPlayingSerialTv) : super(NowPlayingSerialTvEmpty()) {
    on<FetchNowPlayingSerialTv>((event, emit) async {
        emit(NowPlayingSerialTvLoading());
        final nowPlayingSerialTvResult = await _getNowPlayingSerialTv.execute();

        nowPlayingSerialTvResult.fold(
              (failure) => emit(NowPlayingSerialTvError(failure.message)),
              (data) => emit(NowPlayingSerialTvHasData(data))
        );
      },
    );
  }
}