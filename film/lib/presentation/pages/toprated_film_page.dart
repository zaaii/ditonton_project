import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:film/presentation/bloc/film_toprated/film_toprated_bloc.dart';
import 'package:film/presentation/widget/film_card_list.dart';

class FilmTopRatedPage extends StatefulWidget {
  static const ROUTE_NAME = '/film-toprated';

  @override
  _FilmTopRatedPageState createState() => _FilmTopRatedPageState();
}

class _FilmTopRatedPageState extends State<FilmTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<FilmTopRatedBloc>().add(FetchFilmTopRated()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Film Top Rated'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<FilmTopRatedBloc, FilmTopRatedState>(builder: (context, state) {
            if (state is FilmTopRatedLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FilmTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final film = state.result[index];
                  return FilmCard(film);
                },
                itemCount: state.result.length,
              );
            } else if (state is FilmTopRatedEmpty) {
              return Center(
                child: Text('Film Top Rated Tidak Ada', style: kSubtitle),
              );
            } else if (state is FilmTopRatedError) {
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
}
