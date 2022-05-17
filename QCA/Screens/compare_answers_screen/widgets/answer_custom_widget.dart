import 'dart:io';

import 'package:flutter/material.dart';

class AnswerCustomWidget extends StatefulWidget {
  final String title;
  final File answerImage;

  AnswerCustomWidget({this.title, this.answerImage});

  @override
  _AnswerCustomWidgetState createState() => _AnswerCustomWidgetState();
}

class _AnswerCustomWidgetState extends State<AnswerCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.all(15),
                color: Colors.black12,
                child: Image.file(
                  widget.answerImage,
                  fit: BoxFit.fill,
                ))
          ],
        ),
      ],
    );
  }
}
