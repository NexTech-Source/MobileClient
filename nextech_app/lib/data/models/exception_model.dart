import 'dart:convert';
import 'package:nextech_app/storage/hive_local_storage.dart';

class ExceptionObject {
  String exceptionName = "";
  String exceptionMessage;
  String exceptionStackTrace;
  String exceptionTime = DateTime.now().toString();
  String exceptionFunction;
  String exceptionFile;
  String exceptionDescription = "";
  int statusCode = 400; //used only in API exceptions
  ExceptionObject(this.exceptionMessage, this.exceptionStackTrace,
      this.exceptionFunction, this.exceptionFile,
      {this.statusCode = 400});
  String exceptionObjectToJson() {
    return json.encode({
      'exception_name': exceptionName,
      'exception_message': exceptionMessage,
      'exception_stacktrace': exceptionStackTrace,
      'exception_time': exceptionTime,
      'exception_filename': exceptionFile,
      'exception_description': exceptionDescription,
      'exception_function': exceptionFunction,
      'exception_email' : HiveStorage.getUser().email,
    });
  }
}
