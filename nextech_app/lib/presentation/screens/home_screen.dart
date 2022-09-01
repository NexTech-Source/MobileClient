import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nextech_app/constants/app_colours.dart';
import 'package:nextech_app/constants/routes.dart';
import 'package:nextech_app/data/locator.dart';
import 'package:nextech_app/data/runtime_state.dart';

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
            "assets/images/background_3.png",
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
          Image.asset(
            "assets/images/upload_docs.png",
            height: 350,
            width: MediaQuery.of(context).size.width*0.9,
          ),
          const Padding(padding: EdgeInsets.only(top:20),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                 
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      NeumorphicText("Quick Scan",textStyle: NeumorphicTextStyle(fontSize: 25,fontWeight: FontWeight.w300,letterSpacing: 3),style: NeumorphicStyle(color: kBlack)),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      NeumorphicButton(
                         padding: const EdgeInsets.all(15),
                        onPressed: () {
                          Navigator.of(context).pushNamed(kCameraRoute);
                        },
                        style: NeumorphicStyle(
                          color: kLightFadishPurple,
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 8,
                          intensity: 0.65,
                          lightSource: LightSource.topLeft,
                          shadowDarkColor: Colors.black,
                          shadowLightColor: Colors.white,
                        ),
                        child: Image.asset("assets/images/scanner.png",height: 100,width: 100,),
                      ),
                    ],
                  ),
                ),
              

               Container(
            
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  NeumorphicText("Upload History",textStyle: NeumorphicTextStyle( fontSize: 25,fontWeight: FontWeight.w300,letterSpacing: 3),style: NeumorphicStyle(color: kBlack),),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  NeumorphicButton(
                    padding: const EdgeInsets.all(15),
                    onPressed: () {
                      Navigator.of(context).pushNamed(kHistoryRoute);
                    },
                    style: NeumorphicStyle(
                      color:  kLightFadishPurple,
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12)),
                      depth: 8,
                      intensity: 0.65,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Colors.black,
                      shadowLightColor: Colors.white,
                    ),
                    child: Image.asset("assets/images/upload_history.png",height: 100,width: 100,),
                  ),
                ],
              ),
            ),
          
         
            
            
            ],
          ),
         
         
          
         
         
        ],
      ),
    );
  }

  Widget welcomeText() {
    return Text("Welcome back Admin !",
        style: TextStyle(
            fontSize: 35, fontWeight: FontWeight.w500, color: kBlack));
  }


}
