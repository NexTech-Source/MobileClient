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
  var _selectedValue = 'Aadhar Card';
  var _selectedOther = false;
  final TextEditingController docNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  bool isSubmitting = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed(kCameraRollRoute);
        return Future.value(true);
      },
      child: Stack(children: <Widget>[
        Image.asset(
          "assets/images/background_5.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: -10,
          child: Image.asset(
            "assets/images/doc_signing.png",
            height: 300,
          ),
        ),
        Center(
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(clipBehavior: Clip.none, children: [
                  SizedBox(
                      width: 300, height: 400, child: _docContainer(context)),
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
        ),
      ]),
    );
  }

  Widget _docContainer(context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: kLightTransPurple,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 380,
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top:30),),
                      _userNameField(),
                      Padding(padding: EdgeInsets.only(top:20),),
                      _documentDropDown(),
                      Padding(padding: EdgeInsets.only(top:20),),
                      _docNameField(),
                    ],
                  )),
              const Padding(padding: EdgeInsets.only(top: 20)),
              confirmButton(),
            ]));
  }

  Widget _documentDropDown() {
    return SizedBox(
      width: 200,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Document Type',
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 25,

          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        value: 'Aadhar Card',
        items: const [
         
          DropdownMenuItem(
            child: Text('Driving License'),
            value: 'Driving License',
          ),
          DropdownMenuItem(
            child: Text('Birth Certificate'),
            value: 'Birth Certificate',
          ),
          DropdownMenuItem(
            child: Text('Marriage Certificate'),
            value: 'Marriage Certificate',
          ),
          DropdownMenuItem(
            child: Text('Passport'),
            value: 'Passport',
          ),
          DropdownMenuItem(
            child: Text('National ID'),
            value: 'National ID',
          ),
          DropdownMenuItem(
            child: Text('Voter ID'),
            value: 'Voter ID',
          ),
          DropdownMenuItem(
            child: Text('Aadhar Card'),
            value: 'Aadhar Card',
          ),
          DropdownMenuItem(child: Text('PAN Card'), value: 'PAN Card'),
          DropdownMenuItem(child: Text('Other'), value: 'Other'),
        ],
        onChanged: (value) {
          setState(() {
            if (value.toString() == "Other") {
              print("other selected");
              setState(() {
                _selectedOther = true;
                _selectedValue = value.toString();
              });
            } else {
              _selectedOther = false;
              _selectedValue = value.toString();
              setState(() {});
            }
            
          });
        },
      ),
    );
  }

  Widget _docNameField() {
    return _selectedOther
        ? TextFormField(
            controller: docNameController,
            decoration: const InputDecoration(
              icon: Icon(Icons.file_copy),
              hintText: 'Name your Document!',
            ),
            validator: (value) => docNameController.text.length > 3
                ? null
                : 'Document Name is too short',
          )
        : const SizedBox.shrink();
  }

  Widget _userNameField() {
    return SizedBox(
      width: 280,
      child: TextFormField(
        controller: userNameController,
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Your Username',
        ),
        validator: (value) => userNameController.text.length > 3
            ? null
            : 'Document Name is too short',
      ),
    );
  }

  Widget confirmButton() {
    return isSubmitting
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: () async {
              if (_selectedOther) {
                if (docNameController.text.length <= 3 ||
                    userNameController.text.length <= 3) {
                  Flushbar(
                    message:
                        "Document Name and Username must be atleast 4 characters long",
                    duration: Duration(seconds: 3),
                    backgroundColor: kLightTransPurple,
                    flushbarPosition: FlushbarPosition.TOP,
                    icon: Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                  ).show(context);
                } else {
                  setState(() {
                    isSubmitting = true;
                  });
                  bool res = await NetworkService.uploadDocument(
                      docNameController.text,
                      userNameController.text,
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
                }
              } else {
                if (userNameController.text.length <= 3) {
                  Flushbar(
                    message:
                        "Document Name and Username must be atleast 4 characters long",
                    duration: Duration(seconds: 3),
                    backgroundColor: kLightTransPurple,
                    flushbarPosition: FlushbarPosition.TOP,
                    icon: Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                  ).show(context);
                } else {
                  setState(() {
                    isSubmitting = true;
                  });
                  bool res = await NetworkService.uploadDocument(
                      _selectedValue,
                      userNameController.text,
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
                }
              }
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
