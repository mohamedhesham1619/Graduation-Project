import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_analysis/Constants/constants.dart';
import 'package:text_analysis/Provider/app_provider.dart';
import 'package:text_analysis/Screens/compare_answers_screen/compare_answers_screen.dart';
import 'package:text_analysis/Screens/result_screen/widgets/circular_percent_indicator.dart';
import 'package:text_analysis/Screens/student_answer_screen/student_answer_screen.dart';
import 'package:text_analysis/Screens/typical_answer_screen/typical_answer_screen.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  var _isLoading;
  var keywords;
  var percent;


  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final appTheme = Theme.of(context);
    percent = appProvider.similarityPercent;
    keywords = appProvider.keywords;
    (percent != null && keywords != null) ? _isLoading = false : _isLoading = true;
    final buttonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(double.infinity, 50),
      primary: secondaryColor,
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: (_isLoading)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Comparing answers...',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      CircularProgressIndicator()
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(height: 20),
                      CustomPercentIndicator(percent),
                      SizedBox(height: 40),
                      Text('keywords', style: appTheme.textTheme.subtitle2),
                      SizedBox(height: 10),
                      Container(
                        height: 200,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Colors.grey.withOpacity(.4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Text(
                              keywords,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: ElevatedButton(
                              style: buttonStyle,
                              child: Text(
                                'Check a new student answer',
                                style: appTheme.textTheme.button,
                              ),
                              onPressed: () {
                                appProvider.clearStudentAnswer();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            StudentAnswerScreen()));
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: ElevatedButton(
                              style: buttonStyle,
                              child: Text(
                                'Provide a new typical answer',
                                style: appTheme.textTheme.button,
                              ),
                              onPressed: () {
                                appProvider.clearAllAnswers();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            TypicalAnswerScreen()));
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
