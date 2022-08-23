import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

TransactionModel transactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel.fromJson(json);

@HiveType(typeId: 3)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final String tid;
  @HiveField(1)
  DocStatus status;
  @HiveField(2)
  String timestamp;
  @HiveField(3)
  String docName = "" ; 
  
  TransactionModel(this.tid, this.status, this.timestamp);

  TransactionModel.fromJson(Map<String, dynamic> json)
      : tid = json['tid'],
        status = 
            json['message'].contains("green")
                ? DocStatus.green
                : json['message'].contains("red")
                    ? DocStatus.red
                    : DocStatus.yellow,
        timestamp = DateTime.now().toString();
  void setDocName(String docName) {
    this.docName = docName;
  }
}

@HiveType(typeId: 1)
enum DocStatus {
  @HiveField(0)
  green,
  @HiveField(1)
  red,
  @HiveField(2)
  yellow,
}
