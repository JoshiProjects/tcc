import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

Future<String> imageCropperView(String? path, BuildContext context) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: path!,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Recortar Imagem',
          toolbarColor: Color.fromARGB(255, 91, 28, 111),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Recortar Imagem',
      ),
      WebUiSettings(
        context: context,
      ),
    ],
  );

  if (croppedFile != null) {
    print("Imagem recortada");
    return croppedFile.path;
  } else {
    print("não tem imagem");
    return '';
  }
}
