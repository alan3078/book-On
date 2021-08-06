import 'package:flutter/material.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';

void openSnacbar(_scaffoldKey, snacMessage) {
  _scaffoldKey.currentState.showSnackBar(SnackBar(
    duration: Duration(seconds: 4),
    content: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        child: Row(
          children: <Widget>[
            ColoredCircularProgressIndicator(strokeWidth: 4.0),
            Text(
              snacMessage,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        )),
    action: SnackBarAction(
      label: 'Ok',
      textColor: Colors.blueAccent,
      onPressed: () {},
    ),
  ));
}
