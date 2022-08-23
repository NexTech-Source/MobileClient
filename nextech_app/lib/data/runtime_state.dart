//built for sharing global vars across the app in convient way
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:nextech_app/storage/hive_local_storage.dart';

class AppRunTimeStatus {
  List<CameraDescription> cameras = [];
  List<XFile> images = [];
  List<Uint8List> imageBytes = [];
  int selectedCropIndex = 0;
  int selectedRetakeImage = 0;
  List<int> historyNums = [];
  String exceptionMessage = "Internal Server Error, Please try again later";

  setExceptionMessage(String message) {
    exceptionMessage = "An error occured : " + message;
  }

  getExceptionMessage() {
    return exceptionMessage;
  }

  getHistoryNums() {
    historyNums = HiveStorage.historyNums();
  }
}
