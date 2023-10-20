import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

ContestModel ContestModelFromJson(String str) =>
    ContestModel.fromJson(json.decode(str));

String ContestModelToJson(ContestModel data) => json.encode(data.toJson());

class ContestModel {
  // Constructor
  ContestModel({
    required this.id,
    required this.name,
    required this.picture,
    required this.adress,
    required this.date,
    required this.isVerified,
    required this.level,
    required this.participantsId,
  });

  // Fields
  ObjectId id;

  String name;
  dynamic picture;
  String adress;
  DateTime date;
  bool isVerified;

  String level;
  List<ObjectId> participantsId;

  // utility conversion functions
  factory ContestModel.fromJson(Map<String, dynamic> json) => ContestModel(
        id: json["_id"],
        name: json["name"],
        picture: json["picture"],
        adress: json["adress"],
        date: json["date"],
        level: json["level"],
        isVerified: json["isVerified"],
        participantsId:
            List<ObjectId>.from(json["participantsId"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "picture": picture,
        "adress": adress,
        "date": date,
        "level": level,
        "isVerified": isVerified,
        "participantsId": List<dynamic>.from(participantsId.map((x) => x)),
      };
}
