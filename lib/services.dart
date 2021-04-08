import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

abstract class ChartRepo {
  Future<Map> getData();
}

class ChartServices implements ChartRepo {
  static const listUrl =
      'https://api.coindesk.com/v1/bpi/historical/close.json';
  static const priceUrl = 'https://api.coindesk.com/v1/bpi/currentprice.json';

  Future<Map> getData() async {
    Response listResponse = await http.get(Uri.parse(listUrl));
    Response priceResponse = await http.get(Uri.parse(priceUrl));
    final listData = [];
    jsonDecode(listResponse.body)['bpi']
        .forEach((key, value) => listData.add(value));
    final priceData = jsonDecode(priceResponse.body)['bpi']['USD']['rate'];
    return {listData: listData, priceData: priceData};
  }
}
