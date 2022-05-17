import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:text_analysis/Utils/read_text_from_image.dart';

class AppProvider with ChangeNotifier {
  /// ----- Typical answer -----
  File _typicalAnswerImage;

  File get typicalAnswerImage => _typicalAnswerImage;

  addTypicalAnswerImage(File answerImage) {
    _typicalAnswerImage = answerImage;
    notifyListeners();
  }

  String _typicalAnswerText;

  String get typicalAnswerText => _typicalAnswerText;

  // Use OCR on the image and save the text
  analyseTypicalAnswerImage(File image) async {
    final text = await readTextFromImage(image);
    _typicalAnswerText = text.replaceAll('\n', ' ').toLowerCase();
    notifyListeners();
  }

  /// ----- Student answer -----
  File _studentAnswerImage;

  File get studentAnswerImage => _studentAnswerImage;

  addStudentAnswerImage(File image) {
    _studentAnswerImage = image;
    notifyListeners();
  }

  String _studentAnswerText;

  String get studentAnswerText => _studentAnswerText;

  // Use OCR on the image and save the text
  analyseStudentAnswerImage(File image) async {
    final text = await readTextFromImage(image);
    _studentAnswerText = text.replaceAll('\n', ' ').toLowerCase();
    notifyListeners();
  }

  /// ----- Similarity -----

  double _similarityPercent;

  double get similarityPercent => _similarityPercent;

  checkSimilarity() async {
    print('check similarity just called!');
    var url = 'https://text-sim-api.herokuapp.com/';
    var formData = FormData.fromMap(
        {'query': typicalAnswerText, 'secondquery': studentAnswerText});
    print('request just sent , time: ${DateTime.now()}');
    var response = await Dio().post(url, data: formData);
    var similarity = response.data['rate'];
    print('response received: ${response.data}, date: ${DateTime.now()}');
    _similarityPercent = double.parse(similarity);
    notifyListeners();
  }

  /// ----- Keywords in student's answer -----

  String _keywords;

  String get keywords => _keywords;

  getKeywords() async {
    var url = 'https://keyword-ext.herokuapp.com/api/keywords';
    var formData = FormData.fromMap({'query_string': studentAnswerText});
    print('keyWords request sent, date: ${DateTime.now()}');
    var response = await Dio().post(url, data: formData);
    print('keyWords response received, ${response.data}, date: ${DateTime.now()}');
    List keywordsList = response.data['keywords'];
    var keywords = keywordsList.join(' , ');
    _keywords = keywords;
    notifyListeners();
  }

  /// ----- Clear data -----

  clearAllAnswers() {
    _typicalAnswerText = null;
    _typicalAnswerImage = null;
    _studentAnswerText = null;
    _studentAnswerImage = null;
    _similarityPercent = null;
  }

  clearStudentAnswer() {
    _studentAnswerImage = null;
    _studentAnswerText = null;
    _similarityPercent = null;
  }
}
