import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nextech_app/constants/app_colours.dart';
import 'package:nextech_app/constants/routes.dart';
import 'package:nextech_app/data/locator.dart';
import 'package:nextech_app/data/runtime_state.dart';
import 'package:nextech_app/storage/hive_local_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:<Widget>[ 
         Image.asset(
            "assets/images/bacground_2.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        
        Scaffold(
           backgroundColor: Colors.transparent,
          body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60),
          ),
          welcomeText(),
          addDocCard(context),
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
        ],
      )),
    ]
    );
  }

  Widget addDocCard(context) {
    return Card(
      elevation: 0,
    color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Neumorphic(
            style: NeumorphicStyle(
              color: kLightPurple,
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 8,
              intensity: 0.65,
              lightSource: LightSource.topLeft,
              shadowDarkColor: Color.fromARGB(255, 51, 35, 66),
              shadowLightColor: Colors.white,
            ),
            child: Container(
              width: 300,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  NeumorphicText("Quick Scan",textStyle: NeumorphicTextStyle(fontSize: 35,fontWeight: FontWeight.w300,letterSpacing: 3),),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  NeumorphicButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(kCameraRoute);
                    },
                    style: NeumorphicStyle(
                      color: kLightPurple,
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12)),
                      depth: 8,
                      intensity: 0.65,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Colors.black,
                      shadowLightColor: Colors.white,
                    ),
                    child: Image.asset("assets/images/scanner.png",height: 150,width: 150,),
                  ),
                ],
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Neumorphic(
            style: NeumorphicStyle(
              color: kLightPurple,
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 8,
              intensity: 0.65,
              lightSource: LightSource.topLeft,
              shadowDarkColor: Colors.black,
              shadowLightColor: Colors.white,
            ),
            child: Container(
              width: 300,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  NeumorphicText("Upload History",textStyle: NeumorphicTextStyle(fontSize: 35,fontWeight: FontWeight.w300,letterSpacing: 3),),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  NeumorphicButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(kHistoryRoute);
                    },
                    style: NeumorphicStyle(
                      color: kLightPurple,
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12)),
                      depth: 8,
                      intensity: 0.65,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Colors.black,
                      shadowLightColor: Colors.white,
                    ),
                    child: Image.asset("assets/images/upload_history.png",height: 150,width: 150,),
                  ),
                ],
              ),
            ),
          ),
         
          
         
         
        ],
      ),
    );
  }

  Widget welcomeText() {
    return Text("Welcome back ${HiveStorage.getUser().firstName} !",
        style: TextStyle(
            fontSize: 35, fontWeight: FontWeight.w500, color: kPurpleColour));
  }


}
