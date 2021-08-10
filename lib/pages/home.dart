import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:book_on/utils/snacbar.dart';

import 'package:book_on/blocs/google_sheet_bloc.dart';
import 'package:book_on/blocs/internet_bloc.dart';

import 'package:book_on/model/question.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, @required this.name}) : super(key: key);

  final String title;
  final String name;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool googleSheetValid = false;
  String question = "";

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  postAnswer(String answer) async {
    final sb = context.read<GoogleSheetBloc>();
    final ib = context.read<InternetBloc>();

    setState(() {
      googleSheetValid = true;
    });

    if (!ib.hasInternet) {
      openSnacbar(_scaffoldKey, 'check your internet connection!', false);
    } else {
      sb.postAnswer(answerController.text);
      openSnacbar(_scaffoldKey, 'your data submitted', false);
    }
  }

  showFinishDialog() {
    return (showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Your data has submitted'),
        content: const Text('Press OK to exit'),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
            child: const Text('OK'),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<GoogleSheetBloc>();
    nameController.text = widget.name;
    questionController.text = sb.question;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        enabled: false,
                        controller: nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      TextFormField(
                        enabled: false,
                        controller: questionController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(labelText: 'Question'),
                      ),
                      TextFormField(
                        controller: answerController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Answer';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(labelText: 'Answer'),
                      ),
                    ],
                  ),
                )),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              //onPressed: _submitForm,
              onPressed: () => {
                if (_formKey.currentState.validate())
                  {postAnswer(answerController.text), showFinishDialog()}
              },
              child: Text('Submit Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
