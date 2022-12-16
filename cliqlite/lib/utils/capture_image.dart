import 'dart:io';

import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final picker = ImagePicker();
Future<CroppedFile> cropImage(File file, BuildContext context) async {
  CroppedFile croppedImageFile = await ImageCropper().cropImage(
    sourcePath: file.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9,
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
    ],
    // androidUiSettings: AndroidUiSettings(
    //     toolbarTitle: 'Crop Image',
    //     toolbarColor: primaryColor,
    //     toolbarWidgetColor: Colors.white,
    //     initAspectRatio: CropAspectRatioPreset.original,
    //     lockAspectRatio: false),
    // iosUiSettings: IOSUiSettings(
    //   minimumAspectRatio: 1.0,
    // ),
    compressQuality: 100,
    compressFormat: ImageCompressFormat.jpg,
    // maxHeight: 256,
    // maxWidth: 256,
    cropStyle: CropStyle.circle,
  );

  return croppedImageFile;
}

//picks image to post from gallery or from camera
onImagePickerPressed(ImageSource source, BuildContext context) async {
  final imageFile = await picker.getImage(source: source, imageQuality: 30);

  final result = await cropImage(File(imageFile.path), context);

  // print('imageFile:${result.readAsBytesSync().lengthInBytes}');

  return result;
}

onVideoPickerPressed(ImageSource source, BuildContext context) async {
  final videoFile = await picker.getVideo(
    source: source,
  );
  File result = File(videoFile.path);
  return result;
}
