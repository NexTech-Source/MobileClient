import 'package:hive/hive.dart';
part 'doc_status_model.g.dart';
@HiveType(typeId: 0)
class DocStatus extends HiveObject{
  @HiveField(0)
  Status docStatus;
  @HiveField(1)
  String docName = "";
  DocStatus(this.docStatus, this.docName);
}
@HiveType(typeId: 1)
enum Status {
  @HiveField(0)
  green,
  @HiveField(1)
  red,
  @HiveField(2)
  yellow,
}
