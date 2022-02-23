// To parse this JSON data, do
//
//     final chapter = chapterFromJson(jsonString);

import 'dart:convert';

List<Topic> topicFromJson(String str) =>
    List<Topic>.from(json.decode(str).map((x) => Topic.fromJson(x)));

String topicToJson(List<Topic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Topic {
  Topic({
    required this.chapter,
    required this.name,
    required this.id,
  });

  String name;
  String chapter;
  int id;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        chapter: json["chapter"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
