import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';


Contest contestFromJson(String str) => Contest.fromJson(json.decode(str));

String contestToJson(Contest data) => json.encode(data.toJson());

class Contest {

  // Constructor
  Contest({
    required this.id,
    required this.name,
    required this.picture,
    required this.adress,
    required this.date,
    required this.level,
    required this.sexe,
    required this.participantsId,
  });

  // Fields
  ObjectId id;
  String name;
  dynamic picture;
  String adress;
  DateTime date;
  String level;
  String sexe;
  List<ObjectId> participantsId;

  // utility conversion functions
  factory Contest.fromJson(Map<String, dynamic> json) => Contest(
    id: json["id"],
    name: json["name"],
    picture: json["picture"],
    adress: json["adress"],
    date: json["date"],
    level: json["level"],
    sexe: json["sexe"],
    participantsId: List<ObjectId>.from(json["participantsId"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picture": picture,
    "adress": adress,
    "date": date,
    "level": level,
    "sexe": sexe,
    "participantsId": List<dynamic>.from(participantsId.map((x) => x)),
  };
}
