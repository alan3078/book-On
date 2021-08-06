import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:book_on/blocs/internet_bloc.dart';
import 'package:book_on/blocs/google_sheet_bloc.dart';
import 'package:book_on/pages/home.dart';
import 'package:book_on/pages/staff_id.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async  {
  await dotenv.load(fileName: "assets/.env");
  runApp(BookOnApp());
}

class BookOnApp extends StatefulWidget {
  const BookOnApp({Key key}) : super(key: key);

  @override
  _BookOnAppState createState() => _BookOnAppState();
}

class _BookOnAppState extends State<BookOnApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<GoogleSheetBloc>(
          create: (context) => GoogleSheetBloc()),
      ChangeNotifierProvider<InternetBloc>(create: (context) => InternetBloc())
    ], child: MaterialApp(home: StaffIdPage(title: "Book On App")));
  }
}
