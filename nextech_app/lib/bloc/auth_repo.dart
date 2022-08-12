class AuthRepository {

  Future<bool> login(String email, String password) async {
    return Future.delayed(Duration(seconds: 2), () {
      return true;
    });
  }

}