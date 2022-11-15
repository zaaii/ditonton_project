import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/presentation/bloc/film_nowplaying/film_nowplaying_bloc.dart';
import 'package:film/presentation/bloc/film_populer/film_populer_bloc.dart';
import 'package:film/presentation/bloc/film_toprated/film_toprated_bloc.dart';
import 'package:film/presentation/pages/detail_film_page.dart';
import 'package:film/presentation/pages/populer_film_page.dart';
import 'package:film/presentation/pages/toprated_film_page.dart';

class HomeFilmPage extends StatefulWidget {
  @override
  _HomeFilmPageState createState() => _HomeFilmPageState();
}

class _HomeFilmPageState extends State<HomeFilmPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingFilmBloc>().add(FetchNowPlayingFilm());
      context.read<FilmTopRatedBloc>().add(FetchFilmTopRated());
      context.read()<FilmPopulerBloc>().add(FetchFilmPopuler());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Film Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingFilmBloc, NowPlayingFilmState>(builder: (context, state) {
                if (state is NowPlayingFilmLoading) {
                  return const Center(child: CircularProgressIndicator(),);
                } else if (state is NowPlayingFilmHasData) {
                  return ListFilm(state.result);
                } else if (state is NowPlayingFilmEmpty) {
                  return Text("Film Now Playing Tidak Ada");
                } else if (state is NowPlayingFilmError) {
                  return Text(state.message);
                } else {
                  return const Center();
                }
              }),
              _buildSubHeading(
                title: 'Film Populer',
                onTap: () => Navigator.pushNamed(context, FilmPopulerPage.ROUTE_NAME),
              ),
              BlocBuilder<FilmPopulerBloc, FilmPopulerState>(builder: (context, state) {
                if (state is FilmPopulerLoading) {
                  return const Center(child: CircularProgressIndicator(),);
                } else if (state is FilmPopulerHasData) {
                  return ListFilm(state.result);
                } else if (state is FilmPopulerEmpty) {
                  return Text("Film Populer Tidak Ada");
                } else if (state is FilmPopulerError) {
                  return Text(state.message);
                } else {
                  return const Center();
                }
              }),
              _buildSubHeading(
                title: 'Film Top Rated',
                onTap: () => Navigator.pushNamed(context, FilmTopRatedPage.ROUTE_NAME),
              ),
              BlocBuilder<FilmTopRatedBloc, FilmTopRatedState>(builder: (context, state) {
                if (state is FilmTopRatedLoading) {
                  return const Center(child: CircularProgressIndicator(),);
                } else if (state is FilmTopRatedHasData) {
                  return ListFilm(state.result);
                } else if (state is FilmTopRatedEmpty) {
                  return Text("Film Top Rated Tidak Ada");
                } else if (state is FilmTopRatedError) {
                  return Text(state.message);
                } else {
                  return const Center();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('Lihat Selengkapnya'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class ListFilm extends StatelessWidget {
  final List<Film> films;

  ListFilm(this.films);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final film = films[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context,
                  DetailFilmPage.ROUTE_NAME,
                  arguments: film.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${film.posterPath}',
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: films.length,
      ),
    );
  }
}
