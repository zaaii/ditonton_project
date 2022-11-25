import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:film/presentation/bloc/film_populer/film_populer_bloc.dart';
import 'package:film/presentation/widget/film_card_list.dart';

class FilmPopulerPage extends StatefulWidget {
  static const ROUTE_NAME = '/film-populer';

  @override
  _FilmPopulerPageState createState() => _FilmPopulerPageState();
}

class _FilmPopulerPageState extends State<FilmPopulerPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<FilmPopulerBloc>().add(FetchFilmPopuler()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Film Populer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<FilmPopulerBloc, FilmPopulerState>(builder: (context, state) {
            if (state is FilmPopulerLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FilmPopulerHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final film = state.result[index];
                  return FilmCard(film);
                },
                itemCount: state.result.length,
              );
            } else if (state is FilmPopulerEmpty) {
              return Center(child: Text('Film Populer Tidak Ada', style: kSubtitle),);
            } else if (state is FilmPopulerError) {
              return Center(key: Key('error_message'),
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
}
