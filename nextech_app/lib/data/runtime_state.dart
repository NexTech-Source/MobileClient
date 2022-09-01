//built for sharing global vars across the app in convient way
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:nextech_app/data/models/model_exports.dart';
import 'package:nextech_app/storage/hive_local_storage.dart';

class AppRunTimeStatus {
  List<CameraDescription> cameras = [];
  List<XFile> images = [];
  List<Uint8List> imageBytes = [];
  int selectedCropIndex = 0;
  int selectedRetakeImage = 0;
  List<int> historyNums = [];
  String exceptionMessage = "Internal Server Error, Please try again later";
  String currentEmail = "";
  reqListType rlt = reqListType.All;
  List<TransactionModel> transactions = [];

  setExceptionMessage(String message) {
    exceptionMessage = "An error occured : " + message;
  }

  void setTransactionList (reqListType r)
  {
     if (r == reqListType.Red) {
     transactions = HiveStorage.getAllRedTransactions();
    } else if (r == reqListType.Green) {
    transactions = HiveStorage.getAllGreenTransactions();
    } else if (r == reqListType.Yellow) {
     transactions = HiveStorage.getAllYellowTransactions();
    }
    else {
     transactions = HiveStorage.getAllDocUploadHistory();
    }
  }

  void initTranscations()
  {
    transactions = HiveStorage.getAllDocUploadHistory();
  }

  getExceptionMessage() {
    return exceptionMessage;
  }

  getHistoryNums() {
    historyNums = HiveStorage.historyNums();
  }

  void setBetween(DateTime startdate)
  {
    transactions = HiveStorage.getTransactionsBetween(startdate);
  }
}

enum reqListType {
  Red,
  Green,
  Yellow,
  All,
}
