import 'package:ditonton_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:tentang/tentang.dart';


import 'package:film/presentation/bloc/film_detail/film_detail_bloc.dart';
import 'package:film/presentation/bloc/film_nowplaying/film_nowplaying_bloc.dart';
import 'package:film/presentation/bloc/film_populer/film_populer_bloc.dart';
import 'package:film/presentation/bloc/film_recommendation/film_recommendation_bloc.dart';
import 'package:film/presentation/bloc/film_toprated/film_toprated_bloc.dart';
import 'package:film/presentation/bloc/film_watchlist/film_watchlist_bloc.dart';
import 'package:film/presentation/pages/detail_film_page.dart';
import 'package:film/presentation/pages/populer_film_page.dart';
import 'package:film/presentation/pages/toprated_film_page.dart';
import 'package:film/presentation/pages/watchlist_film_page.dart';
import 'package:pencarian/presentation/bloc/pencarian_film/pencarian_film_bloc.dart';
import 'package:pencarian/presentation/bloc/pencarian_serialtv/pencarian_serialtv_bloc.dart';
import 'package:pencarian/presentation/pages/pencarian_page.dart';
import 'package:serialtv/presentation/bloc/serialtv_detail/serialtv_detail_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_nowplaying/serialtv_nowplaying_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_populer/serialtv_populer_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_recommendation/serialtv_recommendation_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_toprated/serialtv_toprated_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_watchlist/serialtv_watchlist_bloc.dart';
import 'package:serialtv/presentation/pages/populer_serialtv_page.dart';
import 'package:serialtv/presentation/pages/toprated_serialtv_page.dart';
import 'package:serialtv/presentation/pages/detail_serialtv_page.dart';
import 'package:serialtv/presentation/pages/watchlist_serialtv_page.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SSLPinning.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        //Film
        BlocProvider(create: (_) => di.locator<DetailFilmBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingFilmBloc>()),
        BlocProvider(create: (_) => di.locator<FilmPopulerBloc>()),
        BlocProvider(create: (_) => di.locator<RecommendationsFilmBloc>()),
        BlocProvider(create: (_) => di.locator<FilmTopRatedBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistFilmBloc>()),
        BlocProvider(create: (_) => di.locator<SearchFilmBloc>()),

        //Serial Tv
        BlocProvider(create: (_) => di.locator<DetailSerialTvBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingSerialTvBloc>()),
        BlocProvider(create: (_) => di.locator<SerialTvPopulerBloc>()),
        BlocProvider(create: (_) => di.locator<RecommendationsSerialTvBloc>()),
        BlocProvider(create: (_) => di.locator<SerialTvTopRatedBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistSerialTvBloc>()),
        BlocProvider(create: (_) => di.locator<SearchSerialTvBloc>()),
      ],
      child: MaterialApp(
        title: 'Ditonton App',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePages(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomePages());

              //Film
            case FilmPopulerPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => FilmPopulerPage());
            case FilmTopRatedPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => FilmTopRatedPage());
            case DetailFilmPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => DetailFilmPage(id: id),
                settings: settings,
              );
            case WatchlistFilmPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistFilmPage());

              //SerialTv
            case SerialTvPopulerPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SerialTvPopulerPage());
            case SerialTvTopRatedPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SerialTvTopRatedPage());
            case DetailSerialTvPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => DetailSerialTvPage(id: id),
                settings: settings,
              );
            case WatchlistSerialTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistSerialTvPage());


            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case TentangPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TentangPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Halaman Tidak Ditemukan :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
