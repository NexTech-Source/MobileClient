import 'package:hive_flutter/hive_flutter.dart';
import 'package:nextech_app/data/models/model_exports.dart';

class HiveStorage {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TokenModelAdapter());
    Hive.registerAdapter(TransactionModelAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(DocStatusAdapter());
    await Hive.openBox<User>('user');
    await Hive.openBox<TransactionModel>('transactions');
    await Hive.openBox<TokenModel>('token');
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
    List<TransactionModel> histTranslist =  Hive.box<TransactionModel>('transactions').values.toList();
    histTranslist.sort((a, b) => DateTime.parse(b.timestamp).compareTo(DateTime.parse(a.timestamp)));
    return histTranslist;
  }

  static List<TransactionModel> getAllYellowTransactions()
  {
    return Hive.box<TransactionModel>('transactions').values.where((element) => element.status == DocStatus.yellow).toList();
  }

  static Future<void> updateTransaction(String tid,DocStatus status) async {
     TransactionModel tm =  Hive.box<TransactionModel>('transactions').get(tid)??TransactionModel(tid, status, DateTime.now().toString());
      tm.status = status; 
      await Hive.box<TransactionModel>('transactions').put(tid, tm);
      tm.save();
  }

  static TokenModel getAuthToken() {
    return Hive.box<TokenModel>('token').get('token')!;
  }

  static List<int> historyNums()
  {
    int yellow = 0; 
    int green = 0;
    int red = 0;
    for(TransactionModel tm in getAllDocUploadHistory())
    {
      switch(tm.status)
      {
        case DocStatus.green:
          green++;
          break;
        case DocStatus.red:
          red++;
          break;
        case DocStatus.yellow:
          yellow++;
          break;
      }
    }
    return [green,yellow,red];
  }
  

  

}
