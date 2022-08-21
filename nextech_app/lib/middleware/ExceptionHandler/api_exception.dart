import 'package:nextech_app/data/Server/network_service.dart';
import 'package:nextech_app/data/locator.dart';
import 'package:nextech_app/data/models/exception_model.dart';
import 'package:nextech_app/data/runtime_state.dart';

class APIException implements Exception {
  ExceptionObject e;
  APIException(this.e);
  Future<void> shootExceptiontoServer() async {
    runTimeState.get<AppRunTimeStatus>().setExceptionMessage(e.exceptionMessage);
    e.exceptionDescription = "Exception Associated With API Operations";
    e.exceptionName = "API Exception Status Code: ${e.statusCode}";
   
  }
}
