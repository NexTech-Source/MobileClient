import 'package:hive/hive.dart';
part 'token_model.g.dart';

TokenModel tokenModelFromJson(Map<String, dynamic> json) => TokenModel.fromJson(json);

@HiveType(typeId: 2)
class TokenModel extends HiveObject {
  @HiveField(0)
  String authToken;
  TokenModel(this.authToken);

  TokenModel.fromJson(Map<String, dynamic> json)
      : authToken = json['token'];

}
