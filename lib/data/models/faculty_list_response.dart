// To parse this JSON data, do
//
//     final teacherListResponse = teacherListResponseFromJson(jsonString);

import 'dart:convert';

List<Faculty> teacherListResponseFromJson(dynamic str) =>
    List<Faculty>.from(str.map((x) => Faculty.fromJson(x)));

String teacherListResponseToJson(List<Faculty> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Faculty {
  Faculty({
    required this.id,
    required this.name,
    required this.phone,
  });

  final int id;
  final String name;
  final String phone;

  factory Faculty.fromJson(Map<String, dynamic> json) =>
      Faculty(id: json["id"], name: json["name"], phone: json["phone"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
      };
}
