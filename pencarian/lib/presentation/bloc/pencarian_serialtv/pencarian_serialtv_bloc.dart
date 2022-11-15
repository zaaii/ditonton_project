import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:pencarian/domain/usecases/pencarian_serialtv.dart';

part 'pencarian_serialtv_event.dart';
part 'pencarian_serialtv_state.dart';

class SearchSerialTvBloc extends Bloc<SearchSerialTvEvent, SearchSerialTvState> {
  final SearchSerialTv _searchSerialTv;

  SearchSerialTvBloc(this._searchSerialTv) : super(SearchSerialTvEmpty()) {
    on<OnQueryChangedSerialTv>((event, emit) async {
      emit(SearchSerialTvLoading());
      final searchSerialTvresult = await _searchSerialTv.execute(event.query);

      searchSerialTvresult.fold(
            (failure) => emit(SearchSerialTvError(failure.message)),
            (searchserialtvdata) => emit(SearchSerialTvHasData(searchserialtvdata)),
      );
    },
      transformer: serialtvDebounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> serialtvDebounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}