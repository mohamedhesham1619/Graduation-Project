import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_analysis/Constants/constants.dart';
import 'package:text_analysis/Provider/app_provider.dart';
import 'package:text_analysis/Screens/compare_answers_screen/widgets/answer_custom_widget.dart';
import 'package:text_analysis/Screens/result_screen/result_screen.dart';

class CompareAnswersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final appTheme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Student answer
              AnswerCustomWidget(
                title: 'Student answer',
                answerImage: appProvider.studentAnswerImage,
              ),

              SizedBox(height: 30),

              /// Typical answer
              AnswerCustomWidget(
                title: 'Typical answer',
                answerImage: appProvider.typicalAnswerImage,
              ),

              SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: secondaryColor,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Compare', style: appTheme.textTheme.button),
                  onPressed: () async {
                    appProvider.checkSimilarity();
                    appProvider.getKeywords();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => ResultScreen()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
