import 'package:core/styles/text_style.dart';
import 'package:film/presentation/pages/home_film_page.dart';
import 'package:film/presentation/pages/watchlist_film_page.dart';
import 'package:flutter/material.dart';
import 'package:pencarian/presentation/pages/pencarian_page.dart';
import 'package:serialtv/presentation/pages/home_serialtv_page.dart';
import 'package:serialtv/presentation/pages/watchlist_serialtv_page.dart';
import 'package:tentang/tentang.dart';

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