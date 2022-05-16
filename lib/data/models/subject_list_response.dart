// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

List<Subject> subjectFromJson(dynamic str) =>
    List<Subject>.from(str.map((x) => Subject.fromJson(x)));

String subjectToJson(List<Subject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subject {
  Subject({
    this.semester = 1,
    required this.name,
    required this.id,
  });

  String name;
  int semester;
  int? id;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        semester: json["semester"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "semester": semester,
      };
}
