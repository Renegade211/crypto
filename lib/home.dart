import 'package:cryptoapp/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cryptoapp/bloc.dart';
import 'package:cryptoapp/events.dart';
import 'package:cryptoapp/states.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
            create: (context) => ChartBloc(chartRepo: ChartServices()),
            child: HomeScreenBloc()));
  }
}

class HomeScreenBloc extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreenBloc> {
  double selected = 50;
  bool other = false;
  bool isLoading = true;
  List<FlSpot> chartData = [];
  List<double> listData = [];
  TextEditingController controller;
  String price = '';
  double priceDouble = 1;

  void getData() async {
    var response = await http.get(
        Uri.parse('https://api.coindesk.com/v1/bpi/historical/close.json'));
    var priceData = await http
        .get(Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json'));
    Map priceJson = jsonDecode(priceData.body);
    String result = priceJson['bpi']['USD']['rate'];
    Map data = jsonDecode(response.body);
    data['bpi'].forEach((key, value) => listData.add(value));
    for (int i = 0; i < listData.length; i++) {
      chartData.add(FlSpot(i.toDouble(), listData[i]));
    }
    setState(() {
      price = result.substring(0, result.length - 5);
      priceDouble = double.parse(price.replaceAll(',', ''));
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    controller = TextEditingController();
  }

  loadData() async {
    context.bloc<ChartBloc>().add(ChartEvents.getData);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void onTapped(double amount) {
    setState(() {
      selected = amount;
      other = false;
    });
  }

  void onSubmit(String value) {
    setState(() {
      other = false;
      selected = double.parse(value.replaceAll(',', '.'));
    });
  }

  void onType() {
    setState(() {
      other = true;
      selected = 0;
      print("Pressed");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey[800],
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 20),
            Text('Bitcoin Price', style: TextStyle(color: Colors.white)),
            SizedBox(height: 5),
            BlocBuilder<ChartBloc, ChartState>(
                builder: (BuildContext context, ChartState state) {
              if (state is ChartLoading) {
                return CupertinoActivityIndicator(radius: 20, animating: true);
              }
              if (state is ChartLoaded) {
                return Text("$price USD",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0));
              }
            }),
            SizedBox(height: 15),
            Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: isLoading
                    ? Container(
                        child: CupertinoActivityIndicator(
                            radius: 20, animating: true))
                    : Container(
                        height: 200,
                        padding: EdgeInsets.fromLTRB(5, 1, 1, 0),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.amber,
                              Colors.amber[700],
                              Colors.amber[800],
                              Colors.amber[900]
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        child: LineChart(LineChartData(
                            lineTouchData: LineTouchData(
                                touchTooltipData: LineTouchTooltipData(
                              tooltipBgColor: const Color(0x00000000),
                            )),
                            borderData: FlBorderData(
                              show: false,
                              border: Border.all(),
                            ),
                            gridData: FlGridData(
                              show: false,
                            ),
                            titlesData: FlTitlesData(
                              show: false,
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                dotData: FlDotData(show: false),
                                colors: [
                                  Colors.white,
                                ],
                                isCurved: true,
                                barWidth: 1,
                                spots: chartData,
                              )
                            ])))),
            Center(
                child: Card(
                    margin: EdgeInsets.all(10.0),
                    elevation: 5.0,
                    child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text('How much Bitcoin do you want to buy?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OutlinedButton(
                                    child: Text('50 USD',
                                        style:
                                            TextStyle(color: Colors.blue[800])),
                                    onPressed: () {
                                      onTapped(50.0);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                selected == 50.0
                                                    ? Colors.blue[100]
                                                    : Colors.white),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25.0)),
                                                side: BorderSide(
                                                    color:
                                                        Colors.blue[800]))))),
                                OutlinedButton(
                                    child: Text('100 USD',
                                        style:
                                            TextStyle(color: Colors.blue[800])),
                                    onPressed: () {
                                      onTapped(100.0);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                selected == 100.0
                                                    ? Colors.blue[100]
                                                    : Colors.white),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25.0)),
                                                side: BorderSide(
                                                    color:
                                                        Colors.blue[800]))))),
                                OutlinedButton(
                                    child: Text('200 USD',
                                        style:
                                            TextStyle(color: Colors.blue[800])),
                                    onPressed: () {
                                      onTapped(200.0);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                selected == 200.0
                                                    ? Colors.blue[100]
                                                    : Colors.white),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25.0)),
                                                side: BorderSide(
                                                    color: Colors.blue[800])))))
                              ],
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  onType();
                                },
                                child: Text('Other',
                                    style: TextStyle(
                                        color: Colors.blue[800], fontSize: 18)),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25.0)),
                                            side: BorderSide(
                                              color: Colors.blue[800],
                                            ))))),
                            other
                                ? TextField(
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter new amount',
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    controller: controller,
                                    onSubmitted: (String value) {
                                      onSubmit(value);
                                    })
                                : Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                        'BTC ${selected * 1 / priceDouble}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.indigo[900],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0))),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text('Buy'),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue[800]),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0)))),
                                ),
                                onPressed: () {
                                  print("Pressed");
                                },
                              ),
                            )
                          ],
                        ))))
          ]),
        ));
  }
}
