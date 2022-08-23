import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nextech_app/constants/app_colours.dart';
import 'package:nextech_app/constants/routes.dart';
import 'package:nextech_app/data/Server/network_service.dart';
import 'package:nextech_app/data/locator.dart';
import 'package:nextech_app/data/runtime_state.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
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
                ? Stack(children: [
         CameraPreview(controller),                         
        Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.7,
              decoration: ShapeDecoration(
                  color: const Color.fromARGB(0, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(width: 1, color: Colors.white))),
            )),
            
        ColorFiltered(
          colorFilter: const ColorFilter.mode(Color.fromARGB(199, 3, 3, 3),BlendMode.srcOut),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height:  MediaQuery.of(context).size.height*0.7,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
            ],
          ),
        ),
        
               
])
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
        const Padding(padding: EdgeInsets.only(left: 20)),
        thumbImage(context),
        const Padding(padding: EdgeInsets.only(left: 66)),
        captureButton(),
        const Padding(padding: EdgeInsets.only(left: 40)),
        submitButton(),
      ],
    );
  }

  Widget submitButton() {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(kConfirmUploadRoute);
        },
        child: Text(
            "Submit (${runTimeState.get<AppRunTimeStatus>().images.length})"));
  }

  Widget thumbImage(context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(kCameraRollRoute);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kTitleL, width: 2),
            borderRadius: BorderRadius.circular(10)),
        height: 60,
        width: 60,
        child: runTimeState.get<AppRunTimeStatus>().images.isEmpty
            ? Icon(Icons.no_photography, color: kTitleL)
            : Image.file(
                File(runTimeState.get<AppRunTimeStatus>().images.last.path)),
      ),
    );
  }

  Widget captureButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kLightPurple,
          onPrimary: Colors.white,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
        ),
        onPressed: () async {
          await HapticFeedback.mediumImpact();
          final image = await controller.takePicture();
          runTimeState.get<AppRunTimeStatus>().images.add(image);
          runTimeState
              .get<AppRunTimeStatus>()
              .imageBytes
              .add(await image.readAsBytes());
          setState(() {});
        },
        child: const Icon(Icons.camera));
  }
}
