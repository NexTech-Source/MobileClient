import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:nextech_app/constants/app_colours.dart';
import 'package:nextech_app/constants/routes.dart';
import 'package:nextech_app/data/Server/network_service.dart';
import 'package:nextech_app/data/locator.dart';
import 'package:nextech_app/data/runtime_state.dart';

class ConfirmUploadScreen extends StatefulWidget {
  const ConfirmUploadScreen({Key? key}) : super(key: key);

  @override
  _ConfirmUploadScreenState createState() => _ConfirmUploadScreenState();
}

class _ConfirmUploadScreenState extends State<ConfirmUploadScreen> {
  final TextEditingController docNameController = TextEditingController();
  bool isSubmitting = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed(kCameraRollRoute);
        return Future.value(true);
      },
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(

              clipBehavior: Clip.none,
              children: [
               
              SizedBox(
                      width: 300, height: 300, child: _docContainer(context)),
                       Positioned(
                  top: -70,
                  left: MediaQuery.of(context).size.width / 2 - 110,
                  child: Image.asset(
                      'assets/images/pen_doc.png',
                      height: 130,
                      width: 130,
                    ),
                  ),
                
          ]),
          
          ],
        ),
      ),
    );
  }
    Widget _docContainer(context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: kLightPurple,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 250, child: _docNameField()),
              const Padding(padding: EdgeInsets.only(top: 20)),
           
             confirmButton(),
            
            ]));
  }

  Widget _docNameField() {
    return TextFormField(
      controller: docNameController,
      decoration: const InputDecoration(
        icon: Icon(Icons.file_copy),
        hintText: 'Name your Document!',
      ),
      validator: (value) => docNameController.text.length > 3
          ? null
          : 'Document Name is too short',
    );
  }

  Widget confirmButton() {
    return isSubmitting
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: () async {
              setState(() {
                isSubmitting = true;
              });
              bool res = await NetworkService.uploadDocument(
                  docNameController.text,
                  runTimeState.get<AppRunTimeStatus>().images);
              
              if (res) {
                await Flushbar(
                  message:
                      "Document Uploaded Successfully, Check the logs on Home Screen",
                  duration: const Duration(seconds: 2),
                  backgroundColor: kSuccessColor,
                ).show(context);
                Navigator.of(context).pushReplacementNamed(kHomeRoute);
              } else {
                await Flushbar(
                  message: "Document Upload Failed, Please try again Later",
                  duration: const Duration(seconds: 2),
                  backgroundColor: kErrorColor,
                ).show(context);
              }
              setState(() {
                isSubmitting = false;
              });
            },
            style: ElevatedButton.styleFrom(
              primary: kGreenSentinel,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            child: const Text("Confirm"));
  }
}
