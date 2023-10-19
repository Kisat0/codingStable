import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

Horse horseFromJson(String str) => Horse.fromJson(json.decode(str));

String horseToJson(Horse data) => json.encode(data.toJson());

class Horse {

  Horse({
    required this.id,
    required this.name,
    required this.picture,
    required this.coat,
    required this.race,
    required this.speciality,
    required this.sexe,
    required this.rentersId,
  });

  // Fields
  ObjectId id;
  String name;
  dynamic picture;
  String coat;
  String race;
  String speciality;
  String sexe;
  List<ObjectId> rentersId;

  // utility conversion functions
  factory Horse.fromJson(Map<String, dynamic> json) => Horse(
    id: json["id"],
    name: json["name"],
    picture: json["picture"],
    coat: json["coat"],
    race: json["race"],
    speciality: json["speciality"],
    sexe: json["sexe"],
    rentersId: List<ObjectId>.from(json["rentersId"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picture": picture,
    "coat": coat,
    "race": race,
    "speciality": speciality,
    "sexe": sexe,
    "rentersId": List<dynamic>.from(rentersId.map((x) => x)),
  };
}
