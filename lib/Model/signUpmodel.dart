// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

List<Post> postsFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  String? name;
  String? email;
  int? gender;
  String? password;
  int? contactNo;
  int? id;

  Post({
    this.name,
    this.email,
    this.gender,
    this.password,
    this.contactNo,
    this.id,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        name: json["name"],
        email: json["email"],
        gender: json["gender"],
        password: json["password"],
        contactNo: json["contactNo"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "gender": gender,
        "password": password,
        "contactNo": contactNo,
        "id": id,
      };
}
