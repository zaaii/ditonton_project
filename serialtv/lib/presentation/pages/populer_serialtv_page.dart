import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:serialtv/presentation/bloc/serialtv_populer/serialtv_populer_bloc.dart';
import 'package:serialtv/presentation/widget/serialtv_card_list.dart';

class SerialTvPopulerPage extends StatefulWidget {
  static const ROUTE_NAME = '/serialtv-populer';

  @override
  _SerialTvPopulerPageState createState() => _SerialTvPopulerPageState();
}

class _SerialTvPopulerPageState extends State<SerialTvPopulerPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<SerialTvPopulerBloc>().add(FetchSerialTvPopuler()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serial Tv Populer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SerialTvPopulerBloc, SerialTvPopulerState>(builder: (context, state) {
            if (state is SerialTvPopulerLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SerialTvPopulerHasData) {
              return ListView.builder(itemBuilder: (context, index) {
                  final serialtv = state.result[index];
                  return SerialTvCard(serialtv);
                },
                itemCount: state.result.length,
              );
            } else if (state is SerialTvPopulerEmpty) {
              return Center(child: Text('Serial Tv Populer Tidak Ditemukan', style: kSubtitle),
              );
            } else if(state is SerialTvPopulerError) {
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
