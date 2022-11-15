import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film_genre.dart';
import 'package:film/domain/entities/film_detail.dart';
import 'package:film/presentation/bloc/film_detail/film_detail_bloc.dart';
import 'package:film/presentation/bloc/film_recommendation/film_recommendation_bloc.dart';
import 'package:film/presentation/bloc/film_watchlist/film_watchlist_bloc.dart';

class DetailFilmPage extends StatefulWidget {
  static const ROUTE_NAME = '/detailfilm';

  final int id;
  DetailFilmPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailFilmPageState createState() => _DetailFilmPageState();
}

class _DetailFilmPageState extends State<DetailFilmPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<DetailFilmBloc>(context, listen: false)
          .add(FetchDetailFilm(widget.id));
      BlocProvider.of<WatchlistFilmBloc>(context, listen: false)
          .add(LoadWatchListStatusFilm(widget.id));
      BlocProvider.of<RecommendationsFilmBloc>(context, listen: false)
          .add(FetchRecommendationsFilm(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailFilmBloc, DetailFilmState>(builder: (context, state) {
          if (state is DetailFilmLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DetailFilmHasData) {
            final movie = state.result;
            return SafeArea(
              child: DetailContent(movie)
            );
          } else if (state is DetailFilmEmpty) {
            return Center(child: Text("Detail Film Tidak Ada", style: kSubtitle,));
          } else if (state is DetailFilmError) {
            return Center(child: Text(state.message, style: kSubtitle));
          } else {
            return Text('Terjadi Kesalahan :(');
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final DetailFilm film;
  DetailContent(this.film, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${film.posterPath}',
          width: screenWidth,
          placeholder: (context, url)
          => const Center(child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              film.title,
                              style: kHeading5,
                            ),
                            BlocConsumer<WatchlistFilmBloc, WatchlistFilmState>(listener: (context, state) {
                                if (state is WatchlistFilmSuccess) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(state.message)));
                                } else if (state is WatchlistFilmError) {
                                  showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        content: Text(state.message),
                                      );
                                    },
                                  );
                                }
                              },
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    if (state is WatchlistFilmStatus) {
                                      if (!state.isFilmAdded) {
                                        context.read<WatchlistFilmBloc>().add(AddWatchlistFilm(film));
                                      } else {
                                        context.read<WatchlistFilmBloc>().add(DeleteWatchlistFilm(film));
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (state is WatchlistFilmStatus)
                                        if (state.isFilmAdded == false)
                                          const Icon(Icons.add)
                                        else if (state.isFilmAdded == true)
                                          const Icon(Icons.check),
                                      const Text('Tambahkan ke Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(film.genres),
                            ),
                            Text(
                              _showDuration(film.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: film.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${film.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Deskripsi',
                              style: kHeading6,
                            ),
                            Text(film.overview,),
                            SizedBox(height: 16),
                            Text(
                              'Rekomendasi',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationsFilmBloc, RecommendationsFilmState>(builder: (context, state) {
                                if (state is RecommendationsFilmLoading) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (state is RecommendationsFilmError) {
                                  return Text(state.message);
                                } else if (state is RecommendationsFilmEmpty) {
                                  return Text("Rekomendasi Film Tidak Ada", style: kSubtitle);
                                } else if (state is RecommendationsFilmHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final film = state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(context,
                                                DetailFilmPage.ROUTE_NAME,
                                                arguments: film.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: '$BASE_IMAGE_URL${film.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(child: CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.result.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<GenreFilm> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
