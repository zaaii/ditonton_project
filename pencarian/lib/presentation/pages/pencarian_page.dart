import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:film/presentation/widget/film_card_list.dart';
import 'package:serialtv/presentation/widget/serialtv_card_list.dart';

import '../bloc/pencarian_film/pencarian_film_bloc.dart';
import '../bloc/pencarian_serialtv/pencarian_serialtv_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-page';
  final List<Widget> _Page = [PencarianFilmResult(), PencarianSerialTvResult()];

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pencarian'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (query) {
                  context.read<SearchFilmBloc>().add(OnQueryChangedFilm(query));
                  context.read<SearchSerialTvBloc>().add(OnQueryChangedSerialTv(query));
                },
                decoration: InputDecoration(
                    hintText: 'Masukkan Judul....',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                    contentPadding: EdgeInsets.all(12)),
                textInputAction: TextInputAction.search,
              ),
              TabBar(
                indicator: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.white))
                ),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.movie),
                        const SizedBox(width: 8),
                        Text("Film", style: kSubtitle),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.tv),
                        const SizedBox(width: 8),
                        Text("Serial Tv", style: kSubtitle),
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(child: TabBarView(children: _Page))
            ],
          ),
        ),
      ),
    );
  }
}

class PencarianFilmResult extends StatelessWidget {
  const PencarianFilmResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFilmBloc, SearchFilmState>(builder: (context, state) {
      if (state is SearchFilmLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is SearchFilmHasData) {
        final result = state.filmresult;
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final film = result[index];
              return FilmCard(film);
            },
            itemCount: result.length,
          ),
        );
      } else if (state is SearchFilmEmpty) {
        return Expanded(
          child: Center(
            child: Text("Belum ada hasil ", style: kSubtitle),
          ),
        );
      } else if (state is SearchFilmError) {
        return Expanded(child: Center(
          child: Text(state.message),
        ),
        );
      } else {
        return Expanded(
          child: Container(),
        );
      }
    },
    );
  }
}

class PencarianSerialTvResult extends StatelessWidget {
  const PencarianSerialTvResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchSerialTvBloc, SearchSerialTvState>(builder: (context, state) {
      if (state is SearchSerialTvLoading) {
        return const Center(child: CircularProgressIndicator()
        );
      } else if (state is SearchSerialTvHasData) {
        final result = state.serialtvresult;
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final serialtv = result[index];
              return SerialTvCard(serialtv);
            },
            itemCount: result.length,
          ),
        );
      } else if (state is SearchSerialTvEmpty) {
        return Expanded(
          child: Center(
            child: Text("Belum ada hasil", style: kSubtitle),
          ),
        );
      } else if (state is SearchSerialTvError) {
        return Expanded(child: Center(
          child: Text(state.message),
        ),
        );
      } else {
        return Expanded(
          child: Container(),
        );
      }
    },
    );
  }
}