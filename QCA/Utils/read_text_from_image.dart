import 'dart:async';
import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';

Future<String> readTextFromImage(File image) async {
  if (image != null) {
    final visionImage = FirebaseVisionImage.fromFile(image);
    final textRecognizer =
        FirebaseVision.instance.cloudDocumentTextRecognizer();
    final visionText = await textRecognizer.processImage(visionImage);
    final text = visionText.text;
    return text;
  }
  return null;
}
