// To parse this JSON data, do
//
//     final topicDetailsResponse = topicDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:folldy_admin/data/models/topic_list_response.dart';

import 'teacher_list_response.dart';

TopicDetailsResponse topicDetailsResponseFromJson(String str) =>
    TopicDetailsResponse.fromJson(json.decode(str));

String topicDetailsResponseToJson(TopicDetailsResponse data) =>
    json.encode(data.toJson());

class TopicDetailsResponse {
  TopicDetailsResponse({
    required this.status,
    required this.data,
  });

  int status;
  Data data;

  factory TopicDetailsResponse.fromJson(Map<String, dynamic> json) =>
      TopicDetailsResponse(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Presentation {
  Presentation({
    required this.teacher,
    required this.topic,
    required this.id,
    this.audios = const [],
    this.slides = const [],
  });

  Teacher teacher;
  Topic topic;
  int id;
  List<Audio> audios;
  List<Slide> slides;

  factory Presentation.fromJson(Map<String, dynamic> json) => Presentation(
        teacher: Teacher.fromJson(json["teacher"]),
        topic: Topic.fromJson(json["topic"]),
        id: json["id"],
        audios: List<Audio>.from(json["audios"].map((x) => Audio.fromJson(x))),
        slides: List<Slide>.from(json["slides"].map((x) => Slide.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "teacher": teacher.id,
        "topic": topic.id,
        "id": id,
        "audios": List<dynamic>.from(audios.map((x) => x.toJson())),
        "slides": List<dynamic>.from(slides.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.chapter,
    this.presentations = const [],
  });

  int id;
  String name;
  int chapter;
  List<Presentation> presentations;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        chapter: json["chapter"],
        presentations: json["presentations"] == []
            ? []
            : List<Presentation>.from(
                json["presentations"].map((x) => Presentation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "chapter": chapter,
        "presentations": presentations == []
            ? []
            : List<dynamic>.from(presentations.map((x) => x.toJson())),
      };
}

class Audio {
  Audio({
    required this.id,
    required this.language,
    required this.audio,
    required this.presentation,
  });

  int id;
  int language;
  String audio;
  int presentation;

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        id: json["id"],
        language: json["language"],
        audio: json["audio"],
        presentation: json["presentation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language": language,
        "audio": audio,
        "presentation": presentation,
      };
}

class Slide {
  Slide({
    required this.id,
    required this.slide,
    required this.displayOrder,
  });

  int id;
  String slide;
  int displayOrder;

  factory Slide.fromJson(Map<String, dynamic> json) => Slide(
        id: json["id"],
        slide: json["slide"],
        displayOrder: json["display_order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slide": slide,
        "display_order": displayOrder,
      };
}
