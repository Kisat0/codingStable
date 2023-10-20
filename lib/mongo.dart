import 'package:futter_stable/models/party.dart';
import 'package:futter_stable/models/course.dart';
import 'models/contest.dart';
import 'env.dart';
import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'constants.dart';
import 'models/UserModel.dart';


class MongoDataBase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    inspect(status);

    print("connection faite");

    staticDb = db;
    _staticUsersCollection = db.collection(USERS_COLLECTION_NAME);
    _staticHorsesCollection = db.collection(HORSES_COLLECTION_NAME);
    _staticContestsCollection = db.collection(CONTESTS_COLLECTION_NAME);
    _staticPartiesCollection = db.collection(PARTIES_COLLECTION_NAME);
    _staticCoursesCollection = db.collection(COURSES_COLLECTION_NAME);
    _staticCommentsCollection = db.collection(COMMENTS_COLLECTION_NAME);
    return db;
  }

  static late Db staticDb;
  static late DbCollection _staticUsersCollection;
  static late DbCollection _staticHorsesCollection;
  static late DbCollection _staticContestsCollection;
  static late DbCollection _staticPartiesCollection;
  static late DbCollection _staticCoursesCollection;
  static late DbCollection _staticCommentsCollection;

  static Future<String> insertUser(UserModel user) async {
    try {
      // Business object must be converted to json data object before inserting.
      var result = await _staticUsersCollection.insertOne(user.toJson());
      if (result.isSuccess) {
        print("toto est insérér");
        return "success";
      } else {
        return "an error as occurred";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<String> insertCourse(CourseModel course) async {
    try {
      // Business object must be converted to json data object before inserting.
      var result = await _staticCoursesCollection.insertOne(course.toJson());
      if (result.isSuccess) {
        print("course add");
        return "success";
      } else {
        return "an error as occurred";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<String> insertContest(ContestModel course) async {
    try {
      // Business object must be converted to json data object before inserting.
      var result = await _staticContestsCollection.insertOne(course.toJson());
      if (result.isSuccess) {
        print("course add");
        return "success";
      } else {
        return "an error as occurred";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<String> insertParty(PartyModel course) async {
    try {
      // Business object must be converted to json data object before inserting.
      var result = await _staticPartiesCollection.insertOne(course.toJson());
      if (result.isSuccess) {
        print("Party add with success");
        return "success";
      } else {
        return "an error as occurred";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

}
