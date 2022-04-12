// To parse this JSON data, do
//
//     final sem = semFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Post PostFromJson(String str) => Post.fromJson(json.decode(str));

String PostToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  int userId;
  int id;
  String title;
  String body;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };

  static List<Post> listFromJson(List<dynamic> list) =>
      List<Post>.from(list.map((x) => Post.fromJson(x)));
}
