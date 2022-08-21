import 'package:nextech_app/data/Server/network_service.dart';

class AuthRepository {
  Future<bool> login(String email, String password) async {
    return await NetworkService.loginUser(email, password);
  }
  Future<bool> register(String email, String password) async {
    return await NetworkService.registerUser(email, password);
  }
}
