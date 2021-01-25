import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_request_ui/screens/fund_request_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: Colors.blue,
      ),
      home: MoneyRequestUI(),
    );
  }
}
