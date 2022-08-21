import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:nextech_app/constants/app_colours.dart';
import 'package:nextech_app/constants/routes.dart';
import 'package:nextech_app/data/locator.dart';
import 'package:nextech_app/data/runtime_state.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class CropView extends StatefulWidget {
  const CropView({Key? key}) : super(key: key);

  @override
  _CropViewState createState() => _CropViewState();
}

class _CropViewState extends State<CropView> {
  final CropController _cropController = CropController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popAndPushNamed(kCameraRollRoute);
        return true;
      },
      child: Scaffold(
        backgroundColor: kTitleL,
          body: FutureBuilder(
              future: runTimeState
                  .get<AppRunTimeStatus>()
                  .images
                  .elementAt(
                      runTimeState.get<AppRunTimeStatus>().selectedCropIndex)
                  .readAsBytes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print("SnapShot Data" + snapshot.data.toString());
                  return Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Crop(
                                image: (snapshot.data as Uint8List),
                                controller: _cropController,
                                onCropped: (image) async {
                                  runTimeState
                                          .get<AppRunTimeStatus>()
                                          .imageBytes[
                                      runTimeState
                                          .get<AppRunTimeStatus>()
                                          .selectedCropIndex] = image;
                                  File file = File(runTimeState
                                      .get<AppRunTimeStatus>()
                                      .images
                                      .elementAt(runTimeState
                                          .get<AppRunTimeStatus>()
                                          .selectedCropIndex)
                                      .path);
                                  await file.writeAsBytes(image, flush: true);
                                  runTimeState.get<AppRunTimeStatus>().images[
                                          runTimeState
                                              .get<AppRunTimeStatus>()
                                              .selectedCropIndex] =
                                      XFile(file.path);
                                  imageCache.clear();
                                  imageCache.clearLiveImages();
                                  // setState(() {

                                  // });
                                  Navigator.of(context)
                                      .pushReplacementNamed(kCameraRollRoute);
                                }),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                _cropController.crop();
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: kPurpleColour,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                              child: const Text("Crop"))
                        ],
                      ),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              })),
    );
  }
}
