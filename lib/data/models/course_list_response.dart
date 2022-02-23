// To parse this JSON data, do
//
//     final university = universityFromJson(jsonString);

import 'dart:convert';

List<Course> courseFromJson(String str) =>
    List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
  Course({
    required this.university,
    required this.name,
    required this.id,
  });

  String name;
  String university;
  int id;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        university: json["university"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
