import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:serialtv/domain/entities/serialtv_genre.dart';
import 'package:serialtv/domain/entities/serialtv_detail.dart';
import 'package:serialtv/presentation/bloc/serialtv_detail/serialtv_detail_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_recommendation/serialtv_recommendation_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_watchlist/serialtv_watchlist_bloc.dart';

class DetailSerialTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail_tv';

  final int id;
  DetailSerialTvPage({required this.id});

  @override
  _DetailSerialTvPageState createState() => _DetailSerialTvPageState();
}

class _DetailSerialTvPageState extends State<DetailSerialTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailSerialTvBloc>().add(FetchDetailSerialTv(widget.id));
      context.read<WatchlistSerialTvBloc>().add(LoadWatchListStatusSerialTv(widget.id));
      context.read<RecommendationsSerialTvBloc>().add(FetchRecommendationsSerialTv(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailSerialTvBloc, DetailSerialTvState>(builder: (context, state) {
          if (state is DetailSerialTvLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailSerialTvHasData) {
            final serialtv = state.result;
            return SafeArea(
              child: DetailSerialTvContent(serialtv),
            );
          } else if (state is DetailSerialTvEmpty) {
            return Text("Detail SerialTv Tidak Ada", style: kSubtitle);
          } else if (state is DetailSerialTvError) {
            return Text(state.message);
          } else {
            return Text('Ada yang salah :(');
          }
        },
      ),
    );
  }
}

class DetailSerialTvContent extends StatelessWidget {
  final DetailSerialTv serialtv;

  DetailSerialTvContent(this.serialtv, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${serialtv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const
          Center(child: CircularProgressIndicator()),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              serialtv.name,
                              style: kHeading5,
                            ),
                            BlocConsumer<WatchlistSerialTvBloc, WatchlistSerialTvState>(listener: (context, state) {
                                if (state is WatchlistSerialTvMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)));
                                } else if (state is WatchlistError) {
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
                                    if (state is WatchlistSerialTvStatus) {
                                      if (!state.isSerialTvAdded) {
                                        context.read<WatchlistSerialTvBloc>().add(AddWatchlistSerialTv(serialtv));
                                      } else {
                                        context.read<WatchlistSerialTvBloc>().add(DeleteWatchlistSerialTv(serialtv));
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (state is WatchlistSerialTvStatus)
                                        if (!state.isSerialTvAdded)
                                          const Icon(Icons.add)
                                        else
                                          const Icon(Icons.check),
                                      const Text('Tambahkan ke Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(serialtv.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: serialtv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${serialtv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Deskripsi',
                              style: kHeading6,
                            ),
                            Text(
                              serialtv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Rekomendasi',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationsSerialTvBloc, RecommendationsSerialTvState>(
                              builder: (context, state) {
                                if (state is RecommendationsSerialTvLoading) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (state is RecommendationsSerialTvEmpty) {
                                  return Text("Rekomendasi SerialTv Tidak Ada", style: kSubtitle);
                                } else if (state is RecommendationsSerialTvError) {
                                  return Text(state.message);
                                } else if (state
                                is RecommendationsSerialTvHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final serialtv = state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(context,
                                                DetailSerialTvPage.ROUTE_NAME,
                                                arguments: serialtv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                '$BASE_IMAGE_URL${serialtv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                      child:
                                                      CircularProgressIndicator(),
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

  String _showGenres(List<SerialTvGenre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
