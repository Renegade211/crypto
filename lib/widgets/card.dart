import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final double selected;
  final bool other;
  final TextEditingController controller;
  final double priceDouble;
  final Function onType;
  final Function onSubmit;
  final Function onTapped;
  final Function getPrice;
  final state;

  const CardWidget({
    this.selected,
    this.other,
    this.controller,
    this.priceDouble,
    this.onType,
    this.onSubmit,
    this.onTapped,
    this.getPrice,
    this.state,
  });

  @override
  CardWidgetState createState() => CardWidgetState();
}

class CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                                style: TextStyle(color: Colors.blue[800])),
                            onPressed: () {
                              widget.onTapped(50.0);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        widget.selected == 50.0
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
                                style: TextStyle(color: Colors.blue[800])),
                            onPressed: () {
                              widget.onTapped(100.0);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        widget.selected == 100.0
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
                                style: TextStyle(color: Colors.blue[800])),
                            onPressed: () {
                              widget.onTapped(200.0);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        widget.selected == 200.0
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
                          widget.onType();
                        },
                        child: Text('Other',
                            style: TextStyle(
                                color: Colors.blue[800], fontSize: 18)),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25.0)),
                                    side: BorderSide(
                                      color: Colors.blue[800],
                                    ))))),
                    widget.other
                        ? TextField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              border: OutlineInputBorder(),
                              hintText: 'Enter new amount',
                              hintStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            controller: widget.controller,
                            onSubmitted: (String value) {
                              widget.onSubmit(value);
                            })
                        : Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                                'BTC ${widget.selected * 1 / widget.getPrice(widget.state.getState['price'])}',
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
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue[800]),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)))),
                        ),
                        onPressed: () {
                          print("Pressed");
                        },
                      ),
                    )
                  ],
                ))));
  }
}
