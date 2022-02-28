// To parse this JSON data, do
//
//     final topicDetailsResponse = topicDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'teacher_list_response.dart';
import 'topic_list_response.dart';

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
    required this.id,
    required this.teacher,
    required this.topic,
    this.slides = const [],
    this.audios = const []
  });

  int id;
  Teacher teacher;
  Topic topic;
  List<Slide> slides;
  List<Audio> audios;

  factory Presentation.fromJson(Map<String, dynamic> json) => Presentation(
        id: json["id"],
        teacher: Teacher.fromJson(json["teacher"]),
        topic: Topic.fromJson(json["topic"]),
        slides: List<Slide>.from(json["slides"].map((x) => Slide.fromJson(x))),
        audios: List<Audio>.from(json["audios"].map((x) => Audio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacher": teacher.id,
        "topic": topic.id,
        "audios": List<dynamic>.from(audios.map((x) => x.toJson())),
        "slides": List<dynamic>.from(slides.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.presentations,
    required this.name,
    required this.id,
    required this.chapter,
  });

  List<Presentation> presentations;
  String name;
  int id;
  int chapter;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        presentations: json["presentations"] == []
            ? []
            : List<Presentation>.from(
                json["presentations"].map((x) => Presentation.fromJson(x))),
        name: json["name"],
        id: json["id"],
        chapter: json["chapter"],
      );

  Map<String, dynamic> toJson() => {
        "presentations": presentations == []
            ? []
            : List<dynamic>.from(presentations.map((x) => x.toJson())),
        "name": name,
        "id": id,
        "chapter": chapter,
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
