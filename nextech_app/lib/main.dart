import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextech_app/bloc/auth_repo.dart';
import 'package:nextech_app/data/locator.dart';
import 'package:nextech_app/data/runtime_state.dart';
import 'package:nextech_app/presentation/router.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
void main() async {
  setupRunTimeState();
  WidgetsFlutterBinding.ensureInitialized();
  runTimeState.get<AppRunTimeStatus>().cameras = await availableCameras();
  print("Available Cameras : ${runTimeState.get<AppRunTimeStatus>().cameras.length}");
  runApp(NextechApp(
    router: AppRouter(),
  ));
}

class NextechApp extends StatelessWidget {
  final AppRouter router;
  const NextechApp({Key? key, required this.router}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'Nextech',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}
