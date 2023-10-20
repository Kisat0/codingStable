import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

PartyModel partyFromJson(String str) => PartyModel.fromJson(json.decode(str));

String PartyModelToJson(PartyModel data) => json.encode(data.toJson());

class PartyModel {
  PartyModel({
    required this.id,
    required this.picture,
    required this.date,
    required this.isVerified,
    required this.participantsId,
    required this.type,
  });
  ObjectId id;
  dynamic picture;
  DateTime date;
  bool isVerified;
  List<ObjectId> participantsId;
  String type;

  factory PartyModel.fromJson(Map<String, dynamic> json) => PartyModel(
        id: json["_id"],
        picture: json["picture"],
        date: json["date"],
        isVerified: json["isVerified"],
        participantsId:
            List<ObjectId>.from(json["participantsId"].map((x) => x)),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "picture": picture,
        "date": date,
        "isVerified": isVerified,
        "participantsId": List<dynamic>.from(participantsId.map((x) => x)),
        "type": type,
      };
}
