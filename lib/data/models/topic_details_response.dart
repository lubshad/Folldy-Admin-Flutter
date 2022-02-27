import 'dart:convert';

TopicDetailsResponse topicDetailsResponseFromJson(String str) =>
    TopicDetailsResponse.fromJson(json.decode(str));

String topicDetailsResponseToJson(TopicDetailsResponse data) =>
    json.encode(data.toJson());

class TopicDetailsResponse {
  TopicDetailsResponse({
    required this.status,
    required this.data,
  });

  final int status;
  final Data data;

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

class Data {
  Data({
    required this.id,
    required this.name,
    required this.chapter,
    required this.subject,
    required this.module,
    required this.teacher,
    required this.slides,
  });

  final int id;
  final String name;
  final String chapter;
  final String subject;
  final int module;
  final String teacher;
  final List<Slide> slides;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        chapter: json["chapter"],
        subject: json["subject"],
        module: json["module"],
        teacher: json["teacher"],
        slides: json["slides"] == []
            ? []
            : List<Slide>.from(json["slides"].map((x) => Slide.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "chapter": chapter,
        "subject": subject,
        "module": module,
        "teacher": teacher,
        "slides": List<dynamic>.from(slides.map((x) => x.toJson())),
      };
}

class Slide {
  Slide({
    required this.id,
    required this.slide,
    required this.displayOrder,
  });

  final int id;
  final String slide;
  final int displayOrder;

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
