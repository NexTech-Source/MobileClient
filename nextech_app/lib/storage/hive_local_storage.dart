import 'package:hive_flutter/hive_flutter.dart';
import 'package:nextech_app/data/models/model_exports.dart';

class HiveStorage {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TokenModelAdapter());
    Hive.registerAdapter(TransactionModelAdapter());
    Hive.registerAdapter(DocStatusAdapter());
    Hive.registerAdapter(UserAdapter());
    await Hive.openBox<User>('user');
    await Hive.openBox<TransactionModel>('transactions');
    await Hive.openBox<TokenModel>('token');
    await Hive.openBox<DocStatus>('docStatus');
  }

  static Future<void> storeToken(TokenModel token) async {
    await Hive.box<TokenModel>('token').put('token', token);
    token.save();
  }

  static Future<void> storeUser(User user) async {
    await Hive.box<User>('user').put('user', user);
    user.save();
  }

  static Future<void> storeTransaction(TransactionModel transaction) async {
    await Hive.box<TransactionModel>('transactions').put(transaction.tid, transaction);
    transaction.save();
  }

  static User getUser()  {
    return  Hive.box<User>('user').get('user')!;
  }

  static List<TransactionModel> getAllDocUploadHistory() {
    return Hive.box<TransactionModel>('transactions').values.toList();
  }

  static TokenModel getAuthToken() {
    return Hive.box<TokenModel>('token').get('token')!;
  }

  

}
