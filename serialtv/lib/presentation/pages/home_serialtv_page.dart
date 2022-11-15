import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/presentation/bloc/serialtv_nowplaying/serialtv_nowplaying_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_populer/serialtv_populer_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_toprated/serialtv_toprated_bloc.dart';
import 'package:serialtv/presentation/pages/populer_serialtv_page.dart';
import 'package:serialtv/presentation/pages/toprated_serialtv_page.dart';
import 'package:serialtv/presentation/pages/detail_serialtv_page.dart';

class HomeSerialTvPage extends StatefulWidget {
  @override
  _HomeSerialTvPageState createState() => _HomeSerialTvPageState();
}

class _HomeSerialTvPageState extends State<HomeSerialTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingSerialTvBloc>().add(FetchNowPlayingSerialTv());
      context.read<SerialTvTopRatedBloc>().add(FetchSerialTvTopRated());
      context.read<SerialTvPopulerBloc>().add(FetchSerialTvPopuler());
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
                'Now Playing Serial Tv',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingSerialTvBloc, NowPlayingSerialTvState>(builder: (context, state) {
                if (state is NowPlayingSerialTvLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NowPlayingSerialTvHasData) {
                  return SerialTvList(state.result);
                } else if (state is NowPlayingSerialTvEmpty) {
                  return Text("Serial Tv Now Playing Tidak ada", style: kSubtitle);
                } else if (state is NowPlayingSerialTvError) {
                  return Text(state.message);
                } else {
                  return const Center();
                }
              }),
              _buildSubHeading(
                title: 'Serial Tv Populer',
                onTap: () =>
                    Navigator.pushNamed(context, SerialTvPopulerPage.ROUTE_NAME),
              ),
              BlocBuilder<SerialTvPopulerBloc, SerialTvPopulerState>(builder: (context, state) {
                if (state is SerialTvPopulerLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SerialTvPopulerHasData) {
                  return SerialTvList(state.result);
                } else if (state is SerialTvPopulerEmpty) {
                  return Text("Serial Tv Populer Tidak ada", style: kSubtitle);
                } else if (state is SerialTvPopulerError) {
                  return Text(state.message);
                } else {
                  return const Center();
                }
              }),
              _buildSubHeading(
                title: 'Serial Tv Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, SerialTvTopRatedPage.ROUTE_NAME),
              ),
              BlocBuilder<SerialTvTopRatedBloc, SerialTvTopRatedState>(builder: (context, state) {
                    if (state is SerialTvTopRatedLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SerialTvTopRatedHasData) {
                      return SerialTvList(state.result);
                    } else if (state is SerialTvTopRatedEmpty) {
                      return Text("Serial Tv Top Rated Tidak ada", style: kSubtitle);
                    } else if (state is SerialTvTopRatedError) {
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

class SerialTvList extends StatelessWidget {
  final List<SerialTv> serialtvs;

  SerialTvList(this.serialtvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final serialtv = serialtvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context,
                  DetailSerialTvPage.ROUTE_NAME,
                  arguments: serialtv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${serialtv.posterPath}',
                  placeholder: (context, url) => const
                  Center(child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: serialtvs.length,
      ),
    );
  }
}
