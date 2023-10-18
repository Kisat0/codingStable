import 'env.dart';
import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDataBase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    inspect(status);

    print("connection faite");

    return db;
  }
}
