import 'package:get_it/get_it.dart';
import 'package:nextech_app/data/runtime_state.dart';

final GetIt runTimeState = GetIt.instance;

void setupRunTimeState() {
  runTimeState.registerSingleton<AppRunTimeStatus>(AppRunTimeStatus());
}