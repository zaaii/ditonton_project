import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:serialtv/presentation/bloc/serialtv_nowplaying/serialtv_nowplaying_bloc.dart';
import 'package:serialtv/presentation/widget/serialtv_card_list.dart';

class NowPlayingSerialTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/serialtv-nowplaying';

  @override
  _NowPlayingSerialTvPageState createState() => _NowPlayingSerialTvPageState();
}

class _NowPlayingSerialTvPageState extends State<NowPlayingSerialTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<NowPlayingSerialTvBloc>().add(FetchNowPlayingSerialTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Serial Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingSerialTvBloc, NowPlayingSerialTvState>(builder: (context, state) {
          if (state is NowPlayingSerialTvLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NowPlayingSerialTvHasData) {
            return ListView.builder(itemBuilder: (context, index) {
              final serialtv = state.result[index];
              return SerialTvCard(serialtv);
            },
              itemCount: state.result.length,
            );
          } else if (state is NowPlayingSerialTvEmpty) {
            return Center(child: Text('Serial Tv Now Playing Tidak Ditemukan', style: kSubtitle),
            );
          } else if(state is NowPlayingSerialTvError) {
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
