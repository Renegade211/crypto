import 'package:cryptoapp/bloc/bloc.dart';
import 'package:cryptoapp/widgets/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => ChartBloc(ChartRepo()),
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

  TextEditingController controller;
  double priceDouble = 1;

  void loadData(BuildContext context) {
    final chartBloc = BlocProvider.of<ChartBloc>(context);

    chartBloc.add(ChartEvents.getData);
  }

  @override
  void initState() {
    super.initState();
    loadData(context);
    controller = TextEditingController();
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

  double getPrice(state) {
    String temp = state.replaceAll(' ', '');
    double result = double.parse(temp);
    return result;
  }

  void onType() {
    setState(() {
      other = true;
      selected = 0;
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
            Text('Bitcoin Price',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(height: 5),
            Center(
              child:
                  BlocBuilder<ChartBloc, ChartState>(builder: (context, state) {
                if (state is ChartLoading) {
                  return Container(
                      child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.amber[700])));
                } else if (state is ChartLoadingSuccess) {
                  return Column(
                    children: [
                      Text("USD ${state.getState['price']}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0)),
                      SizedBox(height: 15),
                      Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Container(
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
                                      spots: state.getState['list'],
                                    )
                                  ])))),
                      CardWidget(
                          selected: selected,
                          other: other,
                          controller: controller,
                          priceDouble: priceDouble,
                          onType: onType,
                          onSubmit: onSubmit,
                          onTapped: onTapped,
                          getPrice: getPrice,
                          state: state)
                    ],
                  );
                } else {
                  return CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.amber[700]));
                }
              }),
            ),
          ]),
        ));
  }
}
