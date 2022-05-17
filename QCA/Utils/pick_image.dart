import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File> pickImage({bool isCamera}) async {
  final picker = ImagePicker();
  var photoSource = isCamera ? ImageSource.camera : ImageSource.gallery;
  final pickedFile = await picker.getImage(source: photoSource);

  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    print('no image picked');
    return null;
  }
}
