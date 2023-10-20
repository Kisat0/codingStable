import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

PartyModel partyFromJson(String str) => PartyModel.fromJson(json.decode(str));

String PartyModelToJson(PartyModel data) => json.encode(data.toJson());

class PartyModel {

  PartyModel({

    required this.picture,
    required this.date,
    required this.participantsId,
    required this.type,
  });



  dynamic picture;
  DateTime date;
  List<ObjectId> participantsId;
  String type;

  factory PartyModel.fromJson(Map<String, dynamic> json) => PartyModel(

    picture: json["picture"],
    date: json["date"],
    participantsId: List<ObjectId>.from(json["participantsId"].map((x) => x)),
    type: json["type"],

  );

  Map<String, dynamic> toJson() => {
    "picture": picture,
    "date": date,
    "participantsId": List<dynamic>.from(participantsId.map((x) => x)),
    "type": type,
  };
}