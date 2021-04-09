import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String title;
  final Function onPress;
  final double selected;

  const ButtonWidget({this.title, this.onPress, this.selected});

  @override
  ButtonWidgetState createState() => ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: widget.onPress(),
        child: Text('${widget.title} USD',
            style: TextStyle(color: Colors.blue[800])),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                widget.selected == 50.0 ? Colors.blue[100] : Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                side: BorderSide(color: Colors.blue[800])))));
  }
}
