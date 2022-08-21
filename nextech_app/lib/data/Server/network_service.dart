import 'package:image_picker/image_picker.dart';
import 'package:nextech_app/constants/urls.dart';
import 'package:nextech_app/middleware/api_service.dart';

class NetworkService{
  static Future<bool> registerUser(String email, String password) async {
    return await APIService(kNTSRegister).registerUser(email,password);
  }
  static Future<bool> loginUser(String email, String password) async {
    return await APIService(kNTSLogin).loginUser(email,password);
  }

  static Future<bool> uploadDocument(List<XFile> images) async {
    return await APIService(kNTSUploadDocument).uploadDocument(images);
  }

  static Future<bool> pollDB(String tid) async 
  {
    return await APIService(kNTSpollDB).pollonDB(tid);
  }

}