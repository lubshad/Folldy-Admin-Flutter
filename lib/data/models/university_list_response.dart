// To parse this JSON data, do
//
//     final university = universityFromJson(jsonString);

import 'dart:convert';

List<University> universityFromJson(String str) => List<University>.from(json.decode(str).map((x) => University.fromJson(x)));

String universityToJson(List<University> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class University {
    University({
        required this.name,
        required this.id,
    });

    String name;
    int id;

    factory University.fromJson(Map<String, dynamic> json) => University(
        name: json["name"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
    };
}
