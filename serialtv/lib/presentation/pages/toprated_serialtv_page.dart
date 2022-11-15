import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:serialtv/presentation/bloc/serialtv_toprated/serialtv_toprated_bloc.dart';
import 'package:serialtv/presentation/widget/serialtv_card_list.dart';

class SerialTvTopRatedPage extends StatefulWidget {
  static const ROUTE_NAME = '/serialtv-toprated';

  @override
  _SerialTvTopRatedTvPageState createState() => _SerialTvTopRatedTvPageState();
}

class _SerialTvTopRatedTvPageState extends State<SerialTvTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<SerialTvTopRatedBloc>().add(FetchSerialTvTopRated()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serial Tv Top Rated'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SerialTvTopRatedBloc, SerialTvTopRatedState>(
          builder: (context, state) {
            if (state is SerialTvTopRatedLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SerialTvTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serialtv = state.result[index];
                  return SerialTvCard(serialtv);
                },
                itemCount: state.result.length,
              );
            } else if (state is SerialTvTopRatedEmpty) {
              return Center(child: Text('Serial Tv Top Rated Tidak Ditemukan', style: kSubtitle));
            } else if (state is SerialTvTopRatedError) {
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
