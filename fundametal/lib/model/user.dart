import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.address,
    this.hobbies,
  });

  String id;
  String name;
  String address;
  List<Hobby> hobbies;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        hobbies:
            List<Hobby>.from(json["hobbies"].map((x) => Hobby.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "hobbies": List<dynamic>.from(hobbies.map((x) => x.toJson())),
      };
}

class Hobby {
  Hobby({
    this.name,
  });

  String name;

  factory Hobby.fromJson(Map<String, dynamic> json) => Hobby(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
