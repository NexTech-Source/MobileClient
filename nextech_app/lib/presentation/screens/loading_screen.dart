import 'package:nextech_app/constants/app_colours.dart';
import 'package:nextech_app/constants/routes.dart';
import 'package:nextech_app/presentation/router.dart';
import 'package:flutter/material.dart';
 import 'package:progress_indicators/progress_indicators.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            children: [
              
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder(
                        future: AppRouter().initialRoute(),
                        builder:
                            (BuildContext context, AsyncSnapshot<String> snap) {
                          if (snap.hasData) {
                            Future.delayed(Duration.zero, () async {
                              await Navigator.of(context)
                                  .popAndPushNamed(snap.data ?? kLoginRoute);
                            });

                            return FadingText(
                              'Loaded',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            );
                          } else {
                           return  SizedBox(
                                    key: const Key("no-data"),
                                    child: FadingText(
                                      "Loading",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  );
                          }
                        },
                      )
                    ],
                  ))
            ],
          ),
        ]),
      ),
    );
  }
}
