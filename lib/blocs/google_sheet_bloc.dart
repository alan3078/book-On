import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:book_on/model/user.dart';
import 'package:book_on/model/question.dart';
import 'package:intl/intl.dart';

class GoogleSheetBloc extends ChangeNotifier {
  final String uri = dotenv.env['GOOGLE_SHEET_URL'];
  final String STATUS_SUCCESS = "SUCCESS";

  bool _hasError = false;
  bool get hasError => _hasError;

  String _errorCode;
  String get errorCode => _errorCode;

  String _name;
  String get name => _name;

  String _id;
  String get id => _id;

  String _email;
  String get email => _email;

  String _mobileNo;
  String get mobileNo => _mobileNo;

  String _comment;
  String get comment => _comment;

  Response _response;
  Response get response => _response;

  String _question;
  String get question => _question;

  String _answer;
  String get answer => _answer;

  var dio = Dio();

  Future getUsers() async {
    final googleSheetData = await getGoogleSheetData();
    try {
      List userData = googleSheetData['userData'];
      _hasError = false;
      return userData;
    } catch (e) {
      _hasError = true;
      _errorCode = e.toString();
      print(_errorCode);
    }
  }

  Future getUser(String userId) async {
    User user;
    List users = await getUsers();
    users.forEach((element) {
      if (element['id'].toString() == userId) {
        user = User(element['id'].toString(), element['name'].toString());
      }
    });
    return user;
  }

  Future getGoogleSheetData() async {
    final response = await dio.get(uri);
    return response.data;
  }

  Future getQuestions() async {
    final googleSheetData = await getGoogleSheetData();
    try {
      List questionData = googleSheetData['questionData'];
      _hasError = false;
      return questionData;
    } catch (e) {
      _hasError = true;
      _errorCode = e.toString();
      print(_errorCode);
    }
  }

  Future getQuestion() async {
    Question question;
    List questionData = await getQuestions();
    var date = DateTime.now();
    var printDate = DateFormat('EEEE').format(date);
    questionData.forEach((element) {
      if (element['id'].toString() == printDate) {
        question =
            Question(element['id'].toString(), element['question'].toString());
      }
    });
    return question;
  }

  Future signIn(String userId) async {
    User user = await getUser(userId);
    Question question = await getQuestion();
    this._id = user.id;
    this._name = user.name;
    this._question = question.question;
    // this._email = user.email;
    // this._mobileNo = user.mobileNo;
    // this._comment = user.comment;
  }

  Future<void> postAnswer(String answer) async {
    this._answer = answer;
    String postUri = uri +
        "?" +
        "name=${this._name}" +
        "&" +
        "question=${this._question}" +
        "&" +
        "answer=${this._answer}";

    try {
      var response = await Dio().post(
        postUri,
        data: null,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      _hasError = false;
    } catch (e) {
      _hasError = true;
      _errorCode = e.toString();
      print(_errorCode);
    }
  }

  notifyListeners();
}
