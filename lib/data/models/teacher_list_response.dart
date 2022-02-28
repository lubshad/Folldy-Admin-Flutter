// To parse this JSON data, do
//
//     final teacherListResponse = teacherListResponseFromJson(jsonString);

import 'dart:convert';

List<Teacher> teacherListResponseFromJson(dynamic str) => List<Teacher>.from(str.map((x) => Teacher.fromJson(x)));

String teacherListResponseToJson(List<Teacher> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Teacher {
    Teacher({
        required this.id,
        required this.name,
        required this.profile,
    });

    int id;
    String name;
    String profile;

    factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json["id"],
        name: json["name"],
        profile: json["profile"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile": profile,
    };
}
