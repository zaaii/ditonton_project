import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:film/presentation/bloc/film_watchlist/film_watchlist_bloc.dart';
import 'package:film/presentation/widget/film_card_list.dart';

class WatchlistFilmPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-film';

  @override
  _WatchlistFilmPageState createState() => _WatchlistFilmPageState();
}

class _WatchlistFilmPageState extends State<WatchlistFilmPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistFilmBloc>().add(LoadWatchlistFilm()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistFilmBloc>().add(LoadWatchlistFilm());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Film'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistFilmBloc, WatchlistFilmState>(builder: (context, state) {
            if (state is WatchlistFilmLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WatchlistFilmHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final film = state.result[index];
                  return FilmCard(film);
                },
                itemCount: state.result.length,
              );
            } else if (state is WatchlistFilmError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
