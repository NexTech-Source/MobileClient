import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nextech_app/constants/app_colours.dart';
import 'package:nextech_app/constants/routes.dart';
import 'package:nextech_app/data/locator.dart';
import 'package:nextech_app/data/runtime_state.dart';

class RetakeImageScreen extends StatefulWidget{
  const RetakeImageScreen({Key? key}) : super(key: key);

  @override
  _RetakeImageScreenState createState() => _RetakeImageScreenState();
}

class _RetakeImageScreenState extends State<RetakeImageScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
        runTimeState.get<AppRunTimeStatus>().cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: kBlack,
        body: Center(
            child: controller.value.isInitialized
                ? CameraPreview(controller)
                : const Text("Starting camera ...")),
        floatingActionButton: optionTray(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget optionTray() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
    captureButton(),
      ],
    );
  }

  

  Widget captureButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kLightPurple,
          onPrimary: Colors.white,
        
          padding: const EdgeInsets.all(20),
        ),
        onPressed: () async {
          final image = await controller.takePicture();
          runTimeState.get<AppRunTimeStatus>().images[runTimeState.get<AppRunTimeStatus>().selectedRetakeImage] = image;
          runTimeState.get<AppRunTimeStatus>().imageBytes[runTimeState.get<AppRunTimeStatus>().selectedRetakeImage] = await image.readAsBytes();
          setState(() {});
          Navigator.of(context).pushReplacementNamed(kCameraRollRoute);
        },
        child: const Text("Retake"));
  }
}