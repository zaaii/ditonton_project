import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:serialtv/presentation/bloc/serialtv_populer/serialtv_populer_bloc.dart';
import 'package:serialtv/presentation/pages/populer_serialtv_page.dart';

import '../../data_dummy/dummy_objects.dart';

class MockSerialTvPopulerBloc
    extends MockBloc<SerialTvPopulerEvent, SerialTvPopulerState>
    implements SerialTvPopulerBloc {}

class SerialTvPopulerEventFake extends Fake
    implements SerialTvPopulerEvent {}

class SerialTvPopulerStateFake extends Fake
    implements SerialTvPopulerState {}

void main() {
  late MockSerialTvPopulerBloc mockSerialTvPopulerBloc;

  setUpAll(() {
    registerFallbackValue(SerialTvPopulerEventFake());
    registerFallbackValue(SerialTvPopulerStateFake());
  });

  setUp(() {
    mockSerialTvPopulerBloc = MockSerialTvPopulerBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SerialTvPopulerBloc>
        .value(value: mockSerialTvPopulerBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
        when(() => mockSerialTvPopulerBloc.state).thenReturn(SerialTvPopulerLoading());
        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(SerialTvPopulerPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
        when(() => mockSerialTvPopulerBloc.state).thenReturn(SerialTvPopulerHasData(testSerialTvList));
        final listViewFinder = find.byType(ListView);
        await tester.pumpWidget(_makeTestableWidget(SerialTvPopulerPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Empty', (WidgetTester tester) async {
        when(() => mockSerialTvPopulerBloc.state).thenReturn(SerialTvPopulerEmpty());

        final textFinder = find.text('Serial Tv Populer Tidak Ditemukan');
        await tester.pumpWidget(_makeTestableWidget(SerialTvPopulerPage()));

        expect(textFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
        when(() => mockSerialTvPopulerBloc.state).thenReturn(const SerialTvPopulerError('Failed'));

        final textFinder = find.byKey(const Key('error_message'));
        await tester.pumpWidget(_makeTestableWidget(SerialTvPopulerPage()));

        expect(textFinder, findsOneWidget);
      });
}
