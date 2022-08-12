import 'package:flutter/material.dart';
import 'package:nextech_app/constants/routes.dart';
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
            builder: (BuildContext context) => HomeScreen());
      case kLoginRoute:
        return MaterialPageRoute(builder: 
        (BuildContext context) => LoginScreen());
      default :
        return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => LoadingScreen(),
    );
    }
    
  }
}
