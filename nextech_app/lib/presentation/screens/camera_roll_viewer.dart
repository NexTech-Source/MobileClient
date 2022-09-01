import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nextech_app/constants/app_colours.dart';
import 'package:nextech_app/constants/routes.dart';
import 'package:nextech_app/data/locator.dart';
import 'package:nextech_app/data/runtime_state.dart';
import 'dart:io';
import 'package:screenshot/screenshot.dart';

class PageViewingScreen extends StatefulWidget {
  const PageViewingScreen({Key? key}) : super(key: key);

  @override
  _PageViewingScreenState createState() => _PageViewingScreenState();
}

class _PageViewingScreenState extends State<PageViewingScreen> {
  int _pageIndex = 0;
  final List<XFile> _photosList = runTimeState.get<AppRunTimeStatus>().images;

  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        runTimeState.get<AppRunTimeStatus>().images = _photosList;
        Navigator.of(context).pushReplacementNamed(kCameraRoute);
        return Future.value(true);
      },
      child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Stack(children: [
            PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => _pageIndex = index);
                },
                itemCount: runTimeState.get<AppRunTimeStatus>().images.length,
                itemBuilder: (BuildContext context, int position) {
                  return Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: Image.file(
                                File(_photosList.elementAt(position).path))
                            .image,
                      ))));
                }),
            Positioned(
                left: 0.0,
                right: 0.0,
                bottom: MediaQuery.of(context).size.height * 0.11,
                child: Material(
                  color: kTitleL,
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(kCameraRoute);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: kBlueNCS,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            child: Text("Add More",
                                style: TextStyle(color: kBlack))),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: kBlueNCS,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            onPressed: () {
                              print("Submit Pressed 0");
                              if (_photosList.isNotEmpty) {
                                print("Submit Pressed");
                                Navigator.of(context)
                                    .pushReplacementNamed(kConfirmUploadRoute);
                              }
                            },
                            child: Text("Submit",
                                style: TextStyle(color: kBlack))),
                      ]),
                )),
            Positioned(
                left: 0.0,
                right: 0.0,
                bottom: MediaQuery.of(context).size.height * 0.06,
                child: Material(
                  color: kTitleL,
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (_pageIndex != 0) {
                                _controller.previousPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              }
                            },
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.white, size: 28.0)),
                        IconButton(
                            onPressed: () {
                              runTimeState
                                  .get<AppRunTimeStatus>()
                                  .selectedRetakeImage = _pageIndex;
                              Navigator.of(context)
                                  .pushReplacementNamed(kRetakeRoute);
                            },
                            icon: const Icon(Icons.refresh,
                                color: Colors.white, size: 28.0)),
                        IconButton(
                            onPressed: () {
                              runTimeState
                                  .get<AppRunTimeStatus>()
                                  .selectedCropIndex = _pageIndex;
                              Navigator.of(context)
                                  .pushReplacementNamed(kCropRoute);
                            },
                            icon: const Icon(Icons.crop,
                                color: Colors.white, size: 28.0)),
                        IconButton(
                            onPressed: () {
                              if (_pageIndex == 0) {
                                XFile imgOther = runTimeState
                                    .get<AppRunTimeStatus>()
                                    .images
                                    .last;
                                runTimeState
                                        .get<AppRunTimeStatus>()
                                        .images
                                        .last =
                                    runTimeState
                                        .get<AppRunTimeStatus>()
                                        .images
                                        .first;
                                runTimeState
                                    .get<AppRunTimeStatus>()
                                    .images
                                    .first = imgOther;
                                setState(() {});
                              } else {
                                XFile imgOther = runTimeState
                                    .get<AppRunTimeStatus>()
                                    .images
                                    .elementAt(_pageIndex);
                                runTimeState
                                        .get<AppRunTimeStatus>()
                                        .images[_pageIndex] =
                                    runTimeState
                                        .get<AppRunTimeStatus>()
                                        .images[_pageIndex - 1];
                                runTimeState
                                    .get<AppRunTimeStatus>()
                                    .images[_pageIndex - 1] = imgOther;
                                setState(() {});
                              }
                            },
                            icon: const Icon(Icons.swap_horiz,
                                color: Colors.white, size: 28.0)),
                        IconButton(
                            onPressed: () {
                              _photosList.removeAt(_pageIndex);
                              runTimeState.get<AppRunTimeStatus>().images =
                                  _photosList;
                                  if(_photosList.isEmpty)
                                  {
                                    Navigator.of(context).pushReplacementNamed(kCameraRoute);
                                  }

                              setState(() {});
                            },
                            icon: const Icon(Icons.delete,
                                color: Colors.white, size: 28.0)),
                        IconButton(
                            onPressed: () {
                              if (_pageIndex < _photosList.length - 1) {
                                _controller.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              }
                            },
                            icon: const Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 28.0)),
                      ]),
                ))
          ])),
    );
  }
}
