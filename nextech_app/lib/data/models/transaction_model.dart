import 'package:hive/hive.dart';
import 'package:nextech_app/data/models/model_exports.dart';
part 'transaction_model.g.dart';

TransactionModel transactionModelFromJson(Map<String, dynamic> json) => TransactionModel.fromJson(json);

@HiveType(typeId: 3)
class TransactionModel extends HiveObject{
  @HiveField(0)
  final String tid;
  @HiveField(1)
  final DocStatus status; 
  @HiveField(2)
  final String timestamp;
  TransactionModel(this.tid, this.status,this.timestamp);

  TransactionModel.fromJson(Map<String, dynamic> json)
      : tid = json['tid'],
        status = DocStatus(json['message'].contains("green")?Status.green:json['message'].contains("red")?Status.red:Status.yellow,json['message']),
        timestamp = DateTime.now().toString();
  void setDocName(String docName){
    status.docName = docName;
  }
}
