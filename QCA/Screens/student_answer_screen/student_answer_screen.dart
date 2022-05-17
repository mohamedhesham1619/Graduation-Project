import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_analysis/Constants/constants.dart';
import 'package:text_analysis/Provider/app_provider.dart';
import 'package:text_analysis/Screens/compare_answers_screen/compare_answers_screen.dart';
import 'package:text_analysis/Utils/pick_image.dart';
import 'package:text_analysis/Utils/read_text_from_image.dart';

class StudentAnswerScreen extends StatefulWidget {
  @override
  _StudentAnswerScreenState createState() => _StudentAnswerScreenState();
}

class _StudentAnswerScreenState extends State<StudentAnswerScreen> {
  File studentAnswerImage;
  String studentAnswerText;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final appProvider = Provider.of<AppProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              /// The text
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Student answer',
                      style: appTheme.textTheme.headline2,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.text_snippet_outlined,
                      color: Colors.green,
                      size: 30,
                    )
                  ],
                ),
              ),

              /// The buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /// Gallery button
                  getImageButton(theme: appTheme, isCamera: false),

                  Text(
                    'OR',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),

                  /// Camera button
                  getImageButton(theme: appTheme, isCamera: true)
                ],
              ),

              /// The image
              Container(
                height: 250,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black12),
                child: (studentAnswerImage == null)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'lib/Assets/placeholder.jpeg',
                          fit: BoxFit.fill,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          studentAnswerImage,
                          fit: BoxFit.fill,
                        ),
                      ),
              ),

              /// The text from the picked image
              Card(
                margin: EdgeInsets.symmetric(horizontal: 15),
                elevation: 3,
                shadowColor: primaryColor,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(.4),
                  padding: EdgeInsets.all(5),
                  child: (studentAnswerText == null)
                      ? null
                      : SingleChildScrollView(
                          child: Text(studentAnswerText),
                        ),
                ),
              ),

              SizedBox(height: 20),

              /// Confirm button
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// The text above confirm button
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      'Press confirm to check all answers.',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: secondaryColor,
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        'Confirm',
                        style: appTheme.textTheme.button,
                      ),
                      onPressed: () {
                        if (studentAnswerImage != null) {
                          appProvider.addStudentAnswerImage(studentAnswerImage);
                          appProvider
                              .analyseStudentAnswerImage(studentAnswerImage);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (ctx) => CompareAnswersScreen()));
                        } else {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Provide an image first'),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageButton({ThemeData theme, bool isCamera}) {
    return TextButton.icon(
      icon: Icon(
        isCamera ? Icons.camera_alt : Icons.photo_album_outlined,
        color: secondaryColor,
      ),
      label: Text(
        isCamera ? 'Open camera' : 'Open gallery',
        style: theme.textTheme.button.apply(color: primaryColor),
      ),
      onPressed: () async {
        final pickedImage = await pickImage(isCamera: isCamera);
        if (pickedImage != null) {
          studentAnswerText = await readTextFromImage(pickedImage);
          setState(() {
            studentAnswerImage = pickedImage;
          });
        } else {
          print('No image picked!');
        }
      },
    );
  }
}
