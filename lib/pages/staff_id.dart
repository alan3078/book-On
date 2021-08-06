import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

import 'package:book_on/utils/snacbar.dart';
import 'package:book_on/utils/next_screen.dart';

import 'package:book_on/blocs/google_sheet_bloc.dart';
import 'package:book_on/blocs/internet_bloc.dart';

import 'package:book_on/pages/home.dart';

class StaffIdPage extends StatefulWidget {
  StaffIdPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StaffIdPageState createState() => _StaffIdPageState();
}

class _StaffIdPageState extends State<StaffIdPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController idController = TextEditingController();
  var userData;
  
  Future<bool> checkUserifExist() async {
    final sb = context.read<GoogleSheetBloc>();
    final ib = context.read<InternetBloc>();
    var sheet = await sb.getGoogleSheetData();

    if (!ib.hasInternet) {
      openSnacbar(_scaffoldKey, 'check your internet connection!');
    } else {
      if (sheet['userData'] != null) {
        List userData = sheet['userData'];
        userData.forEach((element) {
          if (element['id'] == idController.text) {
            print(element);
            return true;
          }
        });
        openSnacbar(_scaffoldKey, 'cannot find id: ${idController.text} in database');
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: idController,
                        validator: (value) {
                          if (value.trim().length != 6) {
                            return '請輸入6位員工號碼';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: '輸入員工號碼'),
                      ),
                    ],
                  ),
                )),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              //onPressed: _submitForm,
              onPressed: () async {
                bool _status = await checkUserifExist();
                if (_formKey.currentState.validate() && _status) {
                  nextScreen(
                      context,
                      MyHomePage(
                          title: widget.title, staffId: idController.text));
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
