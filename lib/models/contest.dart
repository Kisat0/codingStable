import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';


Contest contestFromJson(String str) => Contest.fromJson(json.decode(str));

  String contestToJson(Contest data) => json.encode(data.toJson());
class Contest {

  // Constructor
  Contest({
    required this.name,
    required this.picture,
    required this.adress,
    required this.date,
    required this.level,
    required this.participantsId,
  });

  // Fields
  String name;
  dynamic picture;
  String adress;
  DateTime date;
  String level;
  List<ObjectId> participantsId;

  // utility conversion functions
  factory Contest.fromJson(Map<String, dynamic> json) => Contest(
    name: json["name"],
    picture: json["picture"],
    adress: json["adress"],
    date: json["date"],
    level: json["level"],
    participantsId: List<ObjectId>.from(json["participantsId"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "picture": picture,
    "adress": adress,
    "date": date,
    "level": level,
    "participantsId": List<dynamic>.from(participantsId.map((x) => x)),
  };
}
