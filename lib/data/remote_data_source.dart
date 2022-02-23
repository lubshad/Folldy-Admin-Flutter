import 'dart:convert';

import 'package:folldy_admin/data/models/university_list_response.dart';
import 'package:http/http.dart' as http;

import 'models/chapter_list_response.dart';
import 'models/course_list_response.dart';
import 'models/institution_list_response.dart';
import 'models/subject_list_response.dart';
import 'models/topic_list_response.dart';

class RemoteDataSource {
  static Future<http.Response> addUniversity(String name) {
    return http.post(
      Uri.parse('http://localhost:8000/api/university_add'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
      }),
    );
  }

  static Future<List<University>> getAllUnivresity() async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/university_list'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return universityFromJson(response.body);
  }

  static deleteUniversity(int id) async {
    await http.delete(
      Uri.parse('http://localhost:8000/api/university/$id'),
    );
  }

  static Future<http.Response> addInstitution(String name, int institution) {
    return http.post(
      Uri.parse('http://localhost:8000/api/institution_add'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        "university": institution,
      }),
    );
  }

  static Future<List<Institution>> getAllInstitutions() async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/institution_list'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return institutionFromJson(response.body);
  }

  static deleteInstitution(int id) async {
    await http.delete(
      Uri.parse('http://localhost:8000/api/institution/$id'),
    );
  }

  static Future<http.Response> addCourse(String name, int course) {
    return http.post(
      Uri.parse('http://localhost:8000/api/course_add'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        "university": course,
      }),
    );
  }

  static Future<List<Course>> getAllCourses() async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/course_list'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return courseFromJson(response.body);
  }

  static deleteCourse(int id) async {
    await http.delete(
      Uri.parse('http://localhost:8000/api/course/$id'),
    );
  }

  static Future<http.Response> addSubject(String name, int course) {
    return http.post(
      Uri.parse('http://localhost:8000/api/subject_add'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        "course": course,
      }),
    );
  }

  static Future<List<Subject>> getAllSubjects() async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/subject_list'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return subjectFromJson(response.body);
  }

  static deleteSubject(int id) async {
    await http.delete(
      Uri.parse('http://localhost:8000/api/subject/$id'),
    );
  }

  static Future<http.Response> addChapter(String name, int subject) {
    return http.post(
      Uri.parse('http://localhost:8000/api/chapter_add'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        "subject": subject,
      }),
    );
  }

  static Future<List<Chapter>> getAllChapters() async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/chapter_list'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return chapterFromJson(response.body);
  }

  static deleteChapter(int id) async {
    await http.delete(
      Uri.parse('http://localhost:8000/api/chapter/$id'),
    );
  }


  static Future<http.Response> addTopic(String name, int chapter) {
    return http.post(
      Uri.parse('http://localhost:8000/api/topic_add'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        "chapter": chapter,
      }),
    );
  }

  static Future<List<Topic>> getAllTopics() async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/topic_list'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return topicFromJson(response.body);
  }

  static deleteTopic(int id) async {
    await http.delete(
      Uri.parse('http://localhost:8000/api/topic/$id'),
    );
  }
}
