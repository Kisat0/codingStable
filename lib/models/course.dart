import 'dart:convert';
import 'dart:ffi';
import 'package:mongo_dart/mongo_dart.dart';

CourseModel CourseModelFromJson(String str) =>
    CourseModel.fromJson(json.decode(str));

String CourseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  // Constructor
  CourseModel({
    required this.id,
    required this.terrain,
    required this.duration,
    required this.speciality,
    required this.date,
    required this.isVerified,
    required this.participantsId,
  });

  // Fields
  ObjectId id;
  String terrain;
  String duration;
  String speciality;
  DateTime date;
  bool isVerified;
  List<ObjectId> participantsId;

  // utility conversion functions
  factory CourseModel.fromJson(Map<String?, dynamic> json) => CourseModel(
        id: json["_id"],
        terrain: json["terrain"],
        duration: json["duration"],
        speciality: json["speciality"],
        date: json["date"],
        isVerified: json["isVerified"],
        participantsId:
            List<ObjectId>.from(json["participantsId"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "terrain": terrain,
        "duration": duration,
        "speciality": speciality,
        "date": date,
        "isVerified": isVerified,
        "participantsId": List<dynamic>.from(participantsId.map((x) => x)),
      };
}
