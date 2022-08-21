import 'package:flutter/material.dart';
import 'package:nextech_app/constants/routes.dart';
import 'package:nextech_app/presentation/screens/camera_roll_viewer.dart';
import 'package:nextech_app/presentation/screens/camera_screen.dart';
import 'package:nextech_app/presentation/screens/crop_image_view.dart';
import 'package:nextech_app/presentation/screens/home_screen.dart';
import 'package:nextech_app/presentation/screens/loading_screen.dart';
import 'package:nextech_app/presentation/screens/login_screen.dart';

class AppRouter {
  String runTimeRouteGenerator() {
    return kHomeRoute;
  }

  Future<String> initialRoute() async {
    return kLoginRoute;
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kHomeRoute:
        return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const HomeScreen());
      case kLoginRoute:
        return MaterialPageRoute(builder: 
        (BuildContext context) => LoginScreen());

      case kCameraRoute:
        return MaterialPageRoute(builder: 
        (BuildContext context) => const CameraScreen());
      case kCameraRollRoute:
        return MaterialPageRoute(builder: 
        (BuildContext context) => const PageViewingScreen());
      case kCropRoute:
        return MaterialPageRoute(builder: 
        (BuildContext context) => const CropView());
      default :
        return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => LoadingScreen(),
    );
    }
    
  }
}
