import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selected = 50;
  final String price = "58 542";

  void onTapped(int amount) {
    setState(() {
      selected = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        body: Column(children: [
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                    image: NetworkImage(
                        'https://s3.tradingview.com/t/TRHIyhs1_big.png')),
              )),
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
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
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
                                                  color: Colors.blue[800]))))),
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
                                                  color: Colors.blue[800]))))),
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
                          Container(
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
        ]));
  }
}
