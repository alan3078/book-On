import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class GoogleSheetBloc extends ChangeNotifier {
  final String uri =
      "https://script.google.com/macros/s/AKfycbwOUQOYFnNGqkFjh5WeDpC7PnRvgKoe3WRpzCdIr_dv-PDknN2MtLpATagpN6QkAGoaIQ/exec";
  final String STATUS_SUCCESS = "SUCCESS";

  String _name;
  String get name => _name;

  String _uid;
  String get uid => _uid;

  String _email;
  String get email => _email;

  String _phone;
  String get phone => _phone;

  String _description;
  String get description => _description;

  Response _response;
  Response get response => _response;

  var dio = Dio();

  Future getGoogleSheetData() async {
    final response = await dio.get(uri);
    //print(response.data);
    return response.data;
  }
}
