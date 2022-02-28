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
    required this.subject,
    required this.name,
    required this.id,
  });

  String name;
  int subject;
  int id;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        subject: json["subject"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {"name": name, "id": id, "subject": subject};
}
