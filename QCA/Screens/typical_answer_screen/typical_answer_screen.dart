import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_analysis/Constants/constants.dart';
import 'package:text_analysis/Provider/app_provider.dart';
import 'package:text_analysis/Screens/student_answer_screen/student_answer_screen.dart';
import 'package:text_analysis/Utils/pick_image.dart';
import 'package:text_analysis/Utils/read_text_from_image.dart';

class TypicalAnswerScreen extends StatefulWidget {
  @override
  _TypicalAnswerScreenState createState() => _TypicalAnswerScreenState();
}

class _TypicalAnswerScreenState extends State<TypicalAnswerScreen> {
  File typicalAnswerImage;
  String typicalAnswerText;

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
                      'Typical answer',
                      style: appTheme.textTheme.headline2,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.assignment_turned_in_rounded,
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
                  getImageButton(theme: appTheme, isCamera: false),
                  Text(
                    'OR',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  getImageButton(theme: appTheme, isCamera: true),
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
                child: (typicalAnswerImage == null)
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
                          typicalAnswerImage,
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
                  child: (typicalAnswerText == null)
                      ? null
                      : SingleChildScrollView(
                          child: Text(typicalAnswerText),
                        ),
                ),
              ),

              SizedBox(height: 50),

              /// Confirm button
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
                    if (typicalAnswerImage != null) {
                      appProvider.addTypicalAnswerImage(typicalAnswerImage);
                      appProvider.analyseTypicalAnswerImage(typicalAnswerImage);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx) => StudentAnswerScreen()));
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Provide an image first'),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                ),
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
          typicalAnswerText = await readTextFromImage(pickedImage);
          setState(() {
            typicalAnswerImage = pickedImage;
          });
        } else {
          print('No image picked!');
        }
      },
    );
  }
}
