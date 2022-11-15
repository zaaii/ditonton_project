import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentang/tentang.dart';
import 'package:core/styles/text_style.dart';
import 'package:film/presentation/bloc/film_nowplaying/film_nowplaying_bloc.dart';
import 'package:film/presentation/bloc/film_populer/film_populer_bloc.dart';
import 'package:film/presentation/bloc/film_toprated/film_toprated_bloc.dart';
import 'package:film/presentation/pages/home_film_page.dart';
import 'package:film/presentation/pages/watchlist_film_page.dart';
import 'package:pencarian/presentation/pages/pencarian_page.dart';
import 'package:serialtv/presentation/bloc/serialtv_nowplaying/serialtv_nowplaying_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_populer/serialtv_populer_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_toprated/serialtv_toprated_bloc.dart';
import 'package:serialtv/presentation/pages/home_serialtv_page.dart';
import 'package:serialtv/presentation/pages/watchlist_serialtv_page.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _index = 0;
  final List<Widget> _page = [HomeFilmPage(), SearchPage(), HomeSerialTvPage()];
  final List<BottomNavigationBarItem> _list = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.movie),
      label: 'Film',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Pencarian',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.tv),
      label: 'Serial Tv',
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingFilmBloc>(context, listen: false)
          .add(FetchNowPlayingFilm());
      BlocProvider.of<FilmTopRatedBloc>(context, listen: false)
          .add(FetchFilmTopRated());
      BlocProvider.of<FilmPopulerBloc>(context, listen: false)
          .add(FetchFilmPopuler());
    });
    Future.microtask(() {
      BlocProvider.of<NowPlayingSerialTvBloc>(context, listen: false)
          .add(FetchNowPlayingSerialTv());
      BlocProvider.of<SerialTvTopRatedBloc>(context, listen: false)
          .add(FetchSerialTvTopRated());
      BlocProvider.of<SerialTvPopulerBloc>(context, listen: false)
          .add(FetchSerialTvPopuler());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('DitontonZaini@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Film', style: kSubtitle),
              onTap: () {
                // FirebaseCrashlytics.instance.crash();
                Navigator.pushNamed(context, WatchlistFilmPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Serial Tv', style: kSubtitle),
              onTap: () {
                Navigator.pushNamed(context, WatchlistSerialTvPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, TentangPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('Tentang', style: kSubtitle),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Ditonton App"),
      ),
      body: _page[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: _list,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        selectedItemColor: Colors.white,
      ),
    );
  }
}