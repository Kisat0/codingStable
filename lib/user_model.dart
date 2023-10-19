import 'package:mongo_dart/mongo_dart.dart';

class User {
  ObjectId _id;
  String pseudo;
  String email;
  String mdp;
  String role;
  String? photo;
  String? phone_number;
  String? age;
  String? FFE_link;

  User(this._id, this.pseudo, this.email, this.mdp, this.role, this.photo,
      this.phone_number, this.age, this.FFE_link);

  UserToString(){
    return 'User{_id: $_id, pseudo: $pseudo, email: $email, mdp: $mdp, role: $role, photo: $photo, phone_number: $phone_number, age: $age, FFE_link: $FFE_link}';
  }
}