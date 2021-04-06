import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selected = 50;
  bool other = false;
  var listData = [];
  var chartData = [];
  TextEditingController controller;
  final String price = "58 542";

  void getData() async {
    var response = await http.get(
        Uri.parse('https://api.coindesk.com/v1/bpi/historical/close.json'));
    jsonDecode(response.body)['bpi']
        .forEach((key, value) => listData.add(value));
    for (int i = 0; i < listData.length; i++) {
      chartData.add(FlSpot(i.toDouble(), listData[i].toDouble()));
    }
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void onTapped(int amount) {
    setState(() {
      selected = amount;
      other = false;
    });
  }

  void onSubmit(String value) {
    setState(() {
      other = false;
      selected = int.parse(value);
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
            Text("USD $price",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
            SizedBox(height: 15),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: LineChart(LineChartData(lineBarsData: [
                      LineChartBarData(
                          isCurved: true,
                          show: true,
                          spots: chartData.length > 0 ? chartData : [FlSpot(1, 1)])
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
                                      onTapped(50);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                selected == 50
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
                                      onTapped(100);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                selected == 100
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
                                      onTapped(200);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                selected == 200
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
                                    child: Text('BTC ${selected * 0.000017}',
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
