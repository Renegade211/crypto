import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cryptoapp/events.dart';
import 'package:cryptoapp/services.dart';
import 'package:cryptoapp/states.dart';

class ChartBloc extends Bloc<ChartEvents, ChartState> {
  final ChartRepo chartRepo;
  Map chart;
  ChartBloc({this.chartRepo}) : super(ChartInitState());

  @override
  Stream<ChartState> mapEventToState(ChartEvents event) async* {
    switch (event) {
      case ChartEvents.getData:
        yield ChartLoading();
        try {
          chart = await chartRepo.getData();
          yield ChartLoaded(state: chart);
        } catch (e) {
          print(e);
        }
        break;
    }
  }
}
