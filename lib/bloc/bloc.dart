import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:bloc/bloc.dart';

enum ChartEvents { getData }

class ChartRepo {
  Future<Map> getData() async {
    final price = await http
        .get(Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json'));
    final list = await http.get(
        Uri.parse('https://api.coindesk.com/v1/bpi/historical/close.json'));
    String decodedPrice = jsonDecode(price.body)['bpi']['USD']['rate'];
    String priceData =
        decodedPrice.substring(0, decodedPrice.length - 5).replaceAll(',', ' ');
    Map decodedList = jsonDecode(list.body)['bpi'];
    List<double> tempList = [];
    decodedList.forEach((key, value) {
      tempList.add(value);
    });
    List<FlSpot> listData = [];
    for (int i = 0; i < tempList.length; i++) {
      listData.add(FlSpot(i.toDouble(), tempList[i]));
    }
    return {'price': priceData, 'list': listData};
  }
}

abstract class ChartState {}

class ChartLoading extends ChartState {}

class ChartLoadingSuccess extends ChartState {
  final Map state;

  Map get getState => state;

  ChartLoadingSuccess(this.state);
}

class ChartLoadingFailed extends ChartState {}

class ChartBloc extends Bloc<ChartEvents, ChartState> {
  ChartRepo chartRepo;

  ChartBloc(this.chartRepo) : super(ChartLoading());

  ChartState get initialState => ChartLoading();

  @override
  Stream<ChartState> mapEventToState(ChartEvents event) async* {
    switch (event) {
      case ChartEvents.getData:
        yield ChartLoading();
        try {
          Map data = await chartRepo.getData();
          yield ChartLoadingSuccess(data);
        } catch (err) {
          yield ChartLoadingFailed();
        }
    }
  }
}
