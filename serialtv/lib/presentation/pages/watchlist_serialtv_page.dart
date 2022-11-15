import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:serialtv/presentation/bloc/serialtv_watchlist/serialtv_watchlist_bloc.dart';
import 'package:serialtv/presentation/widget/serialtv_card_list.dart';

class WatchlistSerialTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/serialtv-watchlist';

  @override
  _WatchlistSerialTvPageState createState() => _WatchlistSerialTvPageState();
}

class _WatchlistSerialTvPageState extends State<WatchlistSerialTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistSerialTvBloc>().add(LoadWatchlistSerialTv()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    BlocProvider.of<WatchlistSerialTvBloc>(context, listen: false).add(LoadWatchlistSerialTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Serial Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistSerialTvBloc, WatchlistSerialTvState>(builder: (context, state) {
            if (state is WatchlistSerialTvLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WatchlistSerialTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serialtv = state.result[index];
                  return SerialTvCard(serialtv);
                },
                itemCount: state.result.length,
              );
            } else if (state is WatchlistSerialTvEmpty) {
              return Center(child: Text('Belum ada Watchlist Serial Tv', style: kSubtitle));
            } else if (state is WatchlistSerialTvError) {
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
