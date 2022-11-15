import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:film/data/datasources/db/film_database_helper.dart';
import 'package:film/data/datasources/film_local_data_source.dart';
import 'package:film/data/datasources/film_remote_data_source.dart';
import 'package:film/data/repositories/film_repository_impl.dart';
import 'package:film/domain/repositories/film_repository.dart';
import 'package:film/domain/usecases/get_film_detail.dart';
import 'package:film/domain/usecases/get_film_recommendations.dart';
import 'package:film/domain/usecases/get_film_watchlist_status.dart';
import 'package:film/domain/usecases/get_film_nowplaying.dart';
import 'package:film/domain/usecases/get_film_populer.dart';
import 'package:film/domain/usecases/get_film_toprated.dart';
import 'package:film/domain/usecases/get_film_watchlist.dart';
import 'package:film/domain/usecases/remove_film_watchlist.dart';
import 'package:film/domain/usecases/save_film_watchlist.dart';
import 'package:film/presentation/bloc/film_detail/film_detail_bloc.dart';
import 'package:film/presentation/bloc/film_nowplaying/film_nowplaying_bloc.dart';
import 'package:film/presentation/bloc/film_populer/film_populer_bloc.dart';
import 'package:film/presentation/bloc/film_recommendation/film_recommendation_bloc.dart';
import 'package:film/presentation/bloc/film_toprated/film_toprated_bloc.dart';
import 'package:film/presentation/bloc/film_watchlist/film_watchlist_bloc.dart';
import 'package:pencarian/domain/usecases/pencarian_film.dart';
import 'package:pencarian/domain/usecases/pencarian_serialtv.dart';
import 'package:pencarian/presentation/bloc/pencarian_serialtv/pencarian_serialtv_bloc.dart';
import 'package:pencarian/presentation/bloc/pencarian_film/pencarian_film_bloc.dart';
import 'package:serialtv/data/datasources/db/serialtv_database_helper.dart';
import 'package:serialtv/data/datasources/serialtv_local_data_source.dart';
import 'package:serialtv/data/datasources/serialtv_remote_data_source.dart';
import 'package:serialtv/data/repositories/serialtv_repository_impl.dart';
import 'package:serialtv/domain/repositories/serialtv_repository.dart';
import 'package:serialtv/domain/usecases/get_serialtv_now_playing.dart';
import 'package:serialtv/domain/usecases/get_serialtv_populer.dart';
import 'package:serialtv/domain/usecases/get_serialtv_toprated.dart';
import 'package:serialtv/domain/usecases/get_serialtv_detail.dart';
import 'package:serialtv/domain/usecases/get_serialtv_recommendations.dart';
import 'package:serialtv/domain/usecases/get_serialtv_watchlist_status.dart';
import 'package:serialtv/domain/usecases/get_serialtv_watchlist.dart';
import 'package:serialtv/domain/usecases/remove_serialtv_watchlist.dart';
import 'package:serialtv/domain/usecases/save_serialtv_watchlist.dart';
import 'package:serialtv/presentation/bloc/serialtv_detail/serialtv_detail_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_nowplaying/serialtv_nowplaying_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_populer/serialtv_populer_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_recommendation/serialtv_recommendation_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_toprated/serialtv_toprated_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_watchlist/serialtv_watchlist_bloc.dart';

final locator = GetIt.instance;

void init() {

  // Film
  locator.registerFactory(
    () => DetailFilmBloc(locator()),
  );
  locator.registerFactory(
    () => NowPlayingFilmBloc(locator()),
  );
  locator.registerFactory(
    () => FilmPopulerBloc(locator()),
  );
  locator.registerFactory(
    () => RecommendationsFilmBloc(locator()),
  );
  locator.registerFactory(
    () => SearchFilmBloc(locator()),
  );
  locator.registerFactory(
    () => FilmTopRatedBloc(locator()),
  );
  locator.registerFactory(
    () => WatchlistFilmBloc(locator(), locator(), locator(), locator()),
  );

  //Serial Tv
  locator.registerFactory(
    () => DetailSerialTvBloc(locator()),
  );
  locator.registerFactory(
    () => NowPlayingSerialTvBloc(locator()),
  );
  locator.registerFactory(
    () => SerialTvPopulerBloc(locator()),
  );
  locator.registerFactory(
    () => RecommendationsSerialTvBloc(locator()),
  );
  locator.registerFactory(
    () => SearchSerialTvBloc(locator()),
  );
  locator.registerFactory(
    () => SerialTvTopRatedBloc(locator()),
  );
  locator.registerFactory(
    () => WatchlistSerialTvBloc(locator(), locator(), locator(), locator()),
  );

  //UseCase
  //Film
  locator.registerLazySingleton(() => GetNowPlayingFilm(locator()));
  locator.registerLazySingleton(() => GetFilmPopuler(locator()));
  locator.registerLazySingleton(() => GetFilmTopRated(locator()));
  locator.registerLazySingleton(() => GetDetailFilm(locator()));
  locator.registerLazySingleton(() => GetWatchlistFilm(locator()));
  locator.registerLazySingleton(() => GetRecommendationsFilm(locator()));
  locator.registerLazySingleton(() => SearchFilm(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusFilm(locator()));
  locator.registerLazySingleton(() => SaveWatchlistFilm(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistFilm(locator()));

  //Serial Tv
  locator.registerLazySingleton(() => GetNowPlayingSerialTv(locator()));
  locator.registerLazySingleton(() => GetSerialTvPopuler(locator()));
  locator.registerLazySingleton(() => GetDetailSerialTv(locator()));
  locator.registerLazySingleton(() => GetSerialTvTopRated(locator()));
  locator.registerLazySingleton(() => GetRecommendationsSerialTv(locator()));
  locator.registerLazySingleton(() => SearchSerialTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusSerialTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSerialTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSerialTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistSerialTv(locator()));

  // repository
  locator.registerLazySingleton<FilmRepository>(
    () => FilmRepositoryImpl(
      filmremoteDataSource: locator(),
      filmlocalDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<SerialTvRepository>(
    () => SerialTvRepositoryImpl(
      serialTvRemoteDataSource: locator(),
      serialTvLocalDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<FilmRemoteDataSource>(
      () => FilmRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<FilmLocalDataSource>(
      () => FilmLocalDataSourceImpl(filmDatabaseHelper: locator()));
  locator.registerLazySingleton<SerialTvRemoteDataSource>(
      () => SerialTvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SerialTvLocalDataSource>(
      () => SerialTvLocalDataSourceImpl(serialTvDatabaseHelper: locator()));

  // helper
  locator.registerLazySingleton<FilmDatabaseHelper>(() => FilmDatabaseHelper());
  locator.registerLazySingleton<SerialTvDatabaseHelper>(() => SerialTvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => SSLPinning.client);
}
