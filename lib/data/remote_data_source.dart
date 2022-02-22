import 'dart:convert';

import 'package:folldy_admin/data/models/university_list_response.dart';
import 'package:http/http.dart' as http;

import 'models/institution_list_response.dart';

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

  static Future<http.Response> addInstitution(String name, int university) {
    return http.post(
      Uri.parse('http://localhost:8000/api/institution_add'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        "university": university,
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
}
