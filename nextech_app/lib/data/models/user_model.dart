import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 4)
class User extends HiveObject {
  @HiveField(0)
  String userName;
    @HiveField(1)
  String email;
  User(this.userName,this.email,this.firstName,this.lastName);
  @HiveField(2)
  String firstName;
  @HiveField(3)
  String lastName; 


}
