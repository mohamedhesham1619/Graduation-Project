import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:text_analysis/Constants/constants.dart';

class CustomPercentIndicator extends StatelessWidget {
  final double similarity;

  CustomPercentIndicator(this.similarity);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          percent: similarity,
          radius: 200,
          lineWidth: 20,
          animation: true,
          animationDuration: 500,
          center: Text(
            '${(similarity * 100).toStringAsFixed(2)} %',
            style: TextStyle(fontSize: 25, color: primaryColor),
          ),
          progressColor: (similarity >= .7) ? primaryColor : Colors.red,
        ),

      ],
    );
  }
}
