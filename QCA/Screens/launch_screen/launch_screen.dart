import 'dart:async';

import 'package:flutter/material.dart';
import 'package:text_analysis/Constants/constants.dart';
import 'package:text_analysis/Screens/typical_answer_screen/typical_answer_screen.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  // This screen shows for 3 seconds then navigate to typical answer screen
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => TypicalAnswerScreen())));
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final fontStyle1 = appTheme.textTheme.headline2;
    final fontStyle2 = appTheme.textTheme.subtitle1;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Name of the app
              Text(
                'Qca.',
                style: appTheme.textTheme.headline1,
              ),

              SizedBox(height: 90),

              /// The circular shape
              Stack(
                alignment: Alignment.center,
                children: [
                  /// The circle
                  Container(
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(.05),
                      shape: BoxShape.circle,
                    ),
                  ),

                  /// The text
                  Column(
                    children: [
                      Text(
                        'THE FASTEST',
                        style: fontStyle1,
                      ),
                      Text(
                        'ROUTE FOR YOUR',
                        style: fontStyle1,
                      ),
                      Text(
                        'ANSWERS',
                        style: fontStyle1,
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(height: 30),

              /// The text below the circular shape
              Column(
                children: [
                  Text(
                    'Now you can compare your',
                    style: fontStyle2,
                  ),
                  Text(
                    'answer with a press of a',
                    style: fontStyle2,
                  ),
                  Text(
                    'button',
                    style: fontStyle2,
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
