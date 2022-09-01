import 'package:flutter/material.dart';
import 'package:nextech_app/constants/routes.dart';
import 'package:nextech_app/presentation/screens/camera_roll_viewer.dart';
import 'package:nextech_app/presentation/screens/camera_screen.dart';
import 'package:nextech_app/presentation/screens/confirm_upload_screen.dart';
import 'package:nextech_app/presentation/screens/crop_image_view.dart';
import 'package:nextech_app/presentation/screens/home_screen.dart';
import 'package:nextech_app/presentation/screens/loading_screen.dart';
import 'package:nextech_app/presentation/screens/login_screen.dart';
import 'package:nextech_app/presentation/screens/register_user_screen.dart';
import 'package:nextech_app/presentation/screens/retake_image_screen.dart';
import 'package:nextech_app/presentation/screens/transaction_history_viewer.dart';

class AppRouter {
  String runTimeRouteGenerator() {
    return kHomeRoute;
  }

  Future<String> initialRoute() async {
    //TODO: add logic to check whether the the last login was more than 22 hours ago , else continue to home screen
    return kHomeRoute;
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
      case kRegisterRoute:
        return MaterialPageRoute(builder: 
        (BuildContext context) =>  SignUpScreen());
      case kRetakeRoute:
        return MaterialPageRoute(builder: 
        (BuildContext context) => const RetakeImageScreen());
      case kConfirmUploadRoute:
        return MaterialPageRoute(builder: 
        (BuildContext context) =>  const ConfirmUploadScreen());
      case kHistoryRoute:
        return MaterialPageRoute(builder: 
        (BuildContext context) => TransactionHistoryScreen());
      default :
        return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => LoadingScreen(),
    );
    }
    
  }
}
