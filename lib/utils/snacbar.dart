import 'package:flutter/material.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';

void openSnacbar(_scaffoldKey, snacMessage, progress) {
  SnackBar bar = SnackBar(
    content: Container(
      alignment: Alignment.centerLeft,
      height: 60,
      child: Text(
        snacMessage,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    ),
    action: SnackBarAction(
      label: 'Ok',
      textColor: Colors.blueAccent,
      onPressed: () {},
    ),
  );

  SnackBar progressSnackBar = SnackBar(
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
  );

  if (progress) {
    _scaffoldKey.currentState.showSnackBar(progressSnackBar);
  } else {
    _scaffoldKey.currentState.showSnackBar(bar);
  }
}
