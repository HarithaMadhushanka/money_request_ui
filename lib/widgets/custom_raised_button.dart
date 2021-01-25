import 'package:flutter/material.dart';

class CustomRaisedButton extends StatefulWidget {
  final String buttonText;
  final Color buttonColor;
  final Function buttonPressFunction;
  final Icon icon;

  CustomRaisedButton({
    @required this.buttonText,
    @required this.buttonColor,
    @required this.icon,
    this.buttonPressFunction,
  });

  @override
  _CustomRaisedButtonState createState() => _CustomRaisedButtonState();
}

class _CustomRaisedButtonState extends State<CustomRaisedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.height * 0.07,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
      child: RaisedButton.icon(
        elevation: 0,
        color: widget.buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        disabledColor: widget.buttonColor,
        textColor: Colors.white,
        icon: widget.icon,
        label: Text(
          widget.buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
        onPressed: () {
          widget.buttonPressFunction();
        },
      ),
    );
  }
}
