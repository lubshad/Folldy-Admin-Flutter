import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/data/models/topic_list_response.dart';
import 'package:folldy_admin/data/models/university_list_response.dart';

import '../core/api_client.dart';
import '../core/api_constants.dart';

abstract class RemoteDataSource {
  Future<University> addUniversity(Map<String, dynamic> params);

  Future<List<Chapter>> listChapters(Map<String, dynamic> params);
  Future<List<Subject>> listSubjects(Map<String, dynamic> params);

  Future<Chapter> addNewChapter(Map<String, dynamic> params);

  Future<Chapter> deleteChapter(Map<String, dynamic> params);

  Future<List<University>> listUniversitys(Map<String, dynamic> params);

  Future<List<Institution>> listInstitutions(Map<String, dynamic> params);

  Future<List<Course>> listCourses(Map<String, dynamic> params);

  Future<Course> deleteCourse(Map<String, dynamic> params);

  Future<Course> addNewCourse(Map<String, dynamic> params);

  Future<Institution> deleteInstitution(Map<String, dynamic> params);

  Future<Institution> addNewInstitution(Map<String, dynamic> params);

  Future<Subject> addNewSubject(Map<String, dynamic> params);

  Future<Subject> deleteSubject(Map<String, dynamic> params);

  Future<Topic> addNewTopic(Map<String, dynamic> params);

  Future<List<Topic>> listTopicss(Map<String, dynamic> params);

  Future<Topic> deleteTopic(Map<String, dynamic> params);

  Future<Map<String, dynamic>> deleteUniversity(Map<String, dynamic> params);
}

class RemoteDataSourceImplementation implements RemoteDataSource {
  final ApiClient _apiClient;

  RemoteDataSourceImplementation(this._apiClient);

  @override
  Future<University> addUniversity(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.addUniversity, params);
    return University.fromJson(response);
  }

  @override
  Future<List<Chapter>> listChapters(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.listChapters, params);
    return chapterFromJson(response);
  }

  @override
  Future<List<Subject>> listSubjects(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.listSubjects, params);
    return subjectFromJson(response);
  }

  @override
  Future<Chapter> addNewChapter(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.addNewChapter, params);
    return Chapter.fromJson(response);
  }

  @override
  Future<Chapter> deleteChapter(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.deleteChapter, params);
    return Chapter.fromJson(response);
  }

  @override
  Future<List<Course>> listCourses(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.listSubjects, params);
    return courseFromJson(response);
  }

  @override
  Future<List<Institution>> listInstitutions(
      Map<String, dynamic> params) async {
    final response =
        await _apiClient.post(ApiConstants.institutionList, params);
    return institutionFromJson(response);
  }

  @override
  Future<List<University>> listUniversitys(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.universityList, params);
    return universityFromJson(response);
  }

  @override
  Future<Course> addNewCourse(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.addNewCourse, params);
    return Course.fromJson(response);
  }

  @override
  Future<Course> deleteCourse(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.deleteCourse, params);
    return Course.fromJson(response);
  }

  @override
  Future<Institution> addNewInstitution(Map<String, dynamic> params) async {
    final response =
        await _apiClient.post(ApiConstants.addNewInstitution, params);
    return Institution.fromJson(response);
  }

  @override
  Future<Institution> deleteInstitution(Map<String, dynamic> params) async {
    final response =
        await _apiClient.post(ApiConstants.deleteInstitution, params);
    return Institution.fromJson(response);
  }

  @override
  Future<Subject> addNewSubject(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.addNewSubject, params);
    return Subject.fromJson(response);
  }

  @override
  Future<Subject> deleteSubject(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.deleteSubject, params);
    return Subject.fromJson(response);
  }

  @override
  Future<Topic> addNewTopic(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.addNewTopic, params);
    return Topic.fromJson(response);
  }

  @override
  Future<List<Topic>> listTopicss(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.listAllTopic, params);
    return topicFromJson(response);
  }

  @override
  Future<Topic> deleteTopic(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.deleteTopic, params);
    return Topic.fromJson(response);
  }

  @override
  Future<Map<String, dynamic>> deleteUniversity(
      Map<String, dynamic> params) async {
    final response =
        await _apiClient.post(ApiConstants.deleteUniversity, params);
    return response;
  }
}
