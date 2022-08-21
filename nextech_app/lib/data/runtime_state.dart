//built for sharing global vars across the app in convient way
import 'dart:typed_data';

import 'package:camera/camera.dart';
class AppRunTimeStatus {
  List<CameraDescription> cameras = [];
  List<XFile> images = [];
  List<Uint8List> imageBytes = [];
    int selectedCropIndex = 0 ; 
}