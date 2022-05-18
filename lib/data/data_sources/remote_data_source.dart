import 'dart:async';

import 'package:basic_template/basic_template.dart';
import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/data/models/teacher_list_response.dart';
import 'package:folldy_admin/data/models/topic_list_response.dart';
import 'package:folldy_admin/data/models/university_list_response.dart';

import '../core/api_constants.dart';

abstract class RemoteDataSource {
  Future<Map<String, dynamic>> addUniversity(Map<String, dynamic> params);

  Future<List<Chapter>> listChapters(Map<String, dynamic> params);
  Future<List<Subject>> listSubjects(Map<String, dynamic> params);

  Future<Map<String, dynamic>> addNewChapter(Map<String, dynamic> params);

  Future<Map<String, dynamic>> deleteChapter(Map<String, dynamic> params);

  Future<List<University>> listUniversitys(Map<String, dynamic> params);

  Future<List<Institution>> listInstitutions(Map<String, dynamic> params);

  Future<List<Course>> listCourses(Map<String, dynamic> params);

  Future<Map<String, dynamic>> deleteCourse(Map<String, dynamic> params);

  Future<Map<String, dynamic>> addNewCourse(Map<String, dynamic> params);

  Future<Map<String, dynamic>> deleteInstitution(Map<String, dynamic> params);

  Future<Map<String, dynamic>> addNewInstitution(Map<String, dynamic> params);

  Future<Map<String, dynamic>> addNewSubject(Map<String, dynamic> params);

  Future<Map<String, dynamic>> deleteSubject(Map<String, dynamic> params);

  Future<Map<String, dynamic>> addNewTopic(Map<String, dynamic> params);

  Future<List<Topic>> listTopicss(Map<String, dynamic> params);

  Future<Map<String, dynamic>> deleteTopic(Map<String, dynamic> params);

  Future<Map<String, dynamic>> deleteUniversity(Map<String, dynamic> params);

  Future<Map<String, dynamic>> uploadFile(UploadFileParams params);

  Future<List<Teacher>> listTeachers(Map<String, dynamic> params);

  Future<Map<String, dynamic>> addNewTeacher(UploadFileParams params);

  Future<Map<String, dynamic>> deleteTeacher(Map<String, dynamic> params);

  Future<Map<String, dynamic>> addNewPresentation(Map<String, dynamic> params);

  Future<List<Area>> listAreas(Map<String, dynamic> json);

  Future<dynamic> addNewArea(UploadFileParams json);

  Future<dynamic> deleteArea(Map<String, dynamic> json);

  Future<List<Presentation>> getAllPresentations(Map<String, dynamic> json);

  Future<dynamic> deletePresentation(Map<String, dynamic> json);

  FutureOr addPresentationsToChapter(json);

  FutureOr addAreaToSubject(json);
}

class RemoteDataSourceImplementation implements RemoteDataSource {
  final ApiClient _apiClient;

  RemoteDataSourceImplementation(this._apiClient);

  @override
  Future<Map<String, dynamic>> addUniversity(
      Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.addUniversity, params);
    return response;
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
  Future<Map<String, dynamic>> addNewChapter(
      Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.addNewChapter, params);
    return response;
  }

  @override
  Future<Map<String, dynamic>> deleteChapter(
      Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.deleteChapter, params);
    return response;
  }

  @override
  Future<List<Course>> listCourses(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.listCourses, params);
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
  Future<Map<String, dynamic>> addNewCourse(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.addNewCourse, params);
    return response;
  }

  @override
  Future<Map<String, dynamic>> deleteCourse(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.deleteCourse, params);
    return response;
  }

  @override
  Future<Map<String, dynamic>> addNewInstitution(
      Map<String, dynamic> params) async {
    final response =
        await _apiClient.post(ApiConstants.addNewInstitution, params);
    return response;
  }

  @override
  Future<Map<String, dynamic>> deleteInstitution(
      Map<String, dynamic> params) async {
    final response =
        await _apiClient.post(ApiConstants.deleteInstitution, params);
    return response;
  }

  @override
  Future<Map<String, dynamic>> addNewSubject(
      Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.addNewSubject, params);
    return response;
  }

  @override
  Future<Map<String, dynamic>> deleteSubject(
      Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.deleteSubject, params);
    return response;
  }

  @override
  Future<Map<String, dynamic>> addNewTopic(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.addNewTopic, params);
    return response;
  }

  @override
  Future<List<Topic>> listTopicss(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.listAllTopic, params);
    return topicListResponseFromJson(response);
  }

  @override
  Future<Map<String, dynamic>> deleteTopic(Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.deleteTopic, params);
    return response;
  }

  @override
  Future<Map<String, dynamic>> deleteUniversity(
      Map<String, dynamic> params) async {
    final response =
        await _apiClient.post(ApiConstants.deleteUniversity, params);
    return response;
  }

  @override
  Future<Map<String, dynamic>> uploadFile(UploadFileParams params) async {
    final response = await _apiClient.formData(
        data: params.data, files: params.files, path: params.path);
    return response;
  }

  @override
  Future<List<Teacher>> listTeachers(params) async {
    final response =
        await _apiClient.post(ApiConstants.listAllTeachers, params);
    return teacherListResponseFromJson(response);
  }

  @override
  Future<Map<String, dynamic>> addNewTeacher(UploadFileParams params) async {
    final response = await _apiClient.formData(
        data: params.data,
        files: params.files,
        path: ApiConstants.addNewTeacher);
    return response;
  }

  @override
  Future<Map<String, dynamic>> deleteTeacher(
      Map<String, dynamic> params) async {
    final response = await _apiClient.post(ApiConstants.deleteTeacher, params);
    return response;
  }

  @override
  Future<Map<String, dynamic>> addNewPresentation(
      Map<String, dynamic> params) async {
    final response =
        await _apiClient.post(ApiConstants.addNewpresentation, params);
    return response;
  }

  @override
  Future<List<Area>> listAreas(Map<String, dynamic> json) async {
    final response = await _apiClient.post(ApiConstants.listAllAreas, json);
    return areaListResponseFromJson(response);
  }

  @override
  Future addNewArea(UploadFileParams json) async {
    final response = await _apiClient.formData(
        data: json.data, files: json.files, path: ApiConstants.addNewArea);
    return response;
  }

  @override
  Future deleteArea(Map<String, dynamic> json) async {
    final response = await _apiClient.post(ApiConstants.deleteArea, json);
    return response;
  }

  @override
  Future<List<Presentation>> getAllPresentations(
      Map<String, dynamic> json) async {
    final response =
        await _apiClient.post(ApiConstants.listAllpresentations, json);
    return presentationListResponseFromJson(response);
  }

  @override
  Future deletePresentation(Map<String, dynamic> json) async {
    final response =
        await _apiClient.post(ApiConstants.deletepresentation, json);
    return response;
  }

  @override
  FutureOr addPresentationsToChapter(json) async {
    final response =
        await _apiClient.post(ApiConstants.addPresentations, json);
    return response;
  }
  
  @override
  FutureOr addAreaToSubject(json) async {
      final response =
        await _apiClient.post(ApiConstants.addAreaToSubject, json);
    return response;
  }
}
