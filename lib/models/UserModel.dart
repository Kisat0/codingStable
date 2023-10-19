import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {

  // Constructor
  UserModel({
    required this.id,
    required this.pseudo,
    required this.email,
    required this.mdp,
    required this.role,
    required this.userId,
    // optional construction parameter
    this.phoneNumber,
    this.age,
    this.ffeLink,
  });

  // Fields
  ObjectId id;
  String pseudo;
  String email;
  String mdp;
  String role;
  dynamic userId;

  //optional fields
  String? phoneNumber;
  String? age;
  String? ffeLink;

  // utility conversion functions
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    pseudo: json["pseudo"],
    email: json["email"],
    mdp: json["mdp"],
    role: json["role"],
    userId: json["id"],
    phoneNumber: json["phoneNumber"],
    age: json["age"],
    ffeLink: json["ffeLink"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "pseudo": pseudo,
    "email": email,
    "mdp": mdp,
    "role": role,
    "id": userId,
    "phoneNumber": phoneNumber,
    "age": age,
    "ffeLink": ffeLink,
  };
}