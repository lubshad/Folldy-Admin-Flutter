// To parse this JSON data, do
//
//     final subject = subjectFromJson(jsonString);

import 'dart:convert';

List<Chapter> chapterFromJson(dynamic str) =>
    List<Chapter>.from(str.map((x) => Chapter.fromJson(x)));

String chapterToJson(List<Chapter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chapter {
  Chapter({
    required this.name,
    this.id,
    this.module = 1,
  });

  String name;
  int? id;
  int module;

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      Chapter(name: json["name"], id: json["id"], module: json["module"]);

  Map<String, dynamic> toJson() => {"name": name, "id": id, "module": module};
}
