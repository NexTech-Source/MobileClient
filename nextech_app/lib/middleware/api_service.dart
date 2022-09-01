import 'dart:convert';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:nextech_app/data/models/model_exports.dart';
import 'package:nextech_app/data/runtime_state.dart';
import 'package:nextech_app/storage/hive_local_storage.dart';
import '../data/locator.dart';

class APIService {
  String endpointUrl = "";
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  Map requestBody = {};
  APIService(
      [this.endpointUrl = "",
      this.requestBody = const {},
      this.headers = const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }]);

  Future<bool> registerUser(String email, String password) async {
    try {
      final client = http.Client();

      final response = await client.post(Uri.parse(endpointUrl),
          headers: headers,
          body: jsonEncode({
            "email": email,
            "password": password,
          }));
      client.close();
      print("Register User Response " + response.body);
      switch (response.statusCode) {
        case 200:
          return true;
        default:
          runTimeState.get<AppRunTimeStatus>().exceptionMessage =
              jsonDecode(response.body)["message"];
          return false;
      }
    } catch (exception, stackTrace) {
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      final client = http.Client();
      final response = await client.post(Uri.parse(endpointUrl),
          headers: headers,
          body: jsonEncode({
            "email": email,
            "password": password,
          }));
      print("Login User Response " + response.body);
      client.close();
      switch (response.statusCode) {
        case 200:
          await HiveStorage.storeToken(
              TokenModel.fromJson(jsonDecode(response.body)));
          return true;
        default:
          runTimeState.get<AppRunTimeStatus>().exceptionMessage =
              jsonDecode(response.body)["message "];
          return false;
      }
    } catch (exception, stackTrace) {
      return false;
    }
  }

  Future<bool> uploadDocument(
      String docName, String userName, List<XFile> imageFiles) async {
     try {
      final client = http.Client();
      List<String> base64Images = [];
      for (var image in imageFiles) {
        base64Images.add(base64Encode(
            await FlutterImageCompress.compressWithList(
                await image.readAsBytes(),
                quality: 10)));
      }
      final resp = await client.post(Uri.parse(endpointUrl),
          headers: {
            'authToken': 'Bearer ${HiveStorage.getAuthToken().authToken}',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "docName": docName,
            "images": base64Images,
            "numberOfPages": base64Images.length,
            "email": HiveStorage.getUser().email, 
          }));
      print("Upload Document Response ${resp.body}");
      switch (resp.statusCode) {
        case 200:
          TransactionModel transactionModel =
              TransactionModel.fromJson(jsonDecode(resp.body));
          transactionModel.setDocName(docName,userName);
          runTimeState.get<AppRunTimeStatus>().images = [];
           runTimeState.get<AppRunTimeStatus>().imageBytes = [];
          await HiveStorage.storeTransaction(transactionModel);
          return true;
        default:
          return false;
      }
    } catch (exception, stackTrace) {
      print(exception);
      return false;
    }
  }

  Future<bool> pollonDB(String tid) async {
    final client = http.Client();
    final resp = await client.post(Uri.parse(endpointUrl),
        headers: {
          'authToken': 'Bearer ${HiveStorage.getAuthToken().authToken}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "tid": tid,
        }));
    print("Poll on DB Response ${resp.body}");
    switch (resp.statusCode) {
      case 200:
        String status = jsonDecode(resp.body)['message'];
        DocStatus curState = status.contains("Yellow")
            ? DocStatus.yellow
            : status.contains("green")
                ? DocStatus.green
                : DocStatus.red;
        await HiveStorage.updateTransaction(tid, curState);
        return true;
      default:
        return false;
    }
  }
}
