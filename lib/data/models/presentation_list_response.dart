// To parse this JSON data, do
//
//     final presentationListResponse = presentationListResponseFromJson(jsonString);

import 'dart:convert';

List<Presentation> presentationListResponseFromJson(dynamic str) =>
    List<Presentation>.from(str.map((x) => Presentation.fromJson(x)));

String presentationListResponseToJson(List<Presentation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Presentation {
  Presentation({
    required this.area,
    required this.tags,
    required this.name,
    required this.id,
    required this.module,
  });

  String name;
  int id;
  int module;
  int area;
  List<String> tags;

  factory Presentation.fromJson(Map<String, dynamic> json) => Presentation(
        name: json["name"],
        id: json["id"],
        module: json["module"],
        area: json["area"],
        tags: List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "module": module,
        "area": area,
        "tags": tags,
      };
}
