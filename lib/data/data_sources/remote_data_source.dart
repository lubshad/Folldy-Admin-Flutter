import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/data/models/topic_list_response.dart';
import 'package:folldy_admin/data/models/university_list_response.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';

import '../core/api_client.dart';
import '../core/api_constants.dart';

abstract class RemoteDataSource {
  Future<University> addUniversity(University params);

  Future<List<Chapter>> listChapters(NoParams params);
  Future<List<Subject>> listSubjects(NoParams params);

  Future<Chapter> addNewChapter(Chapter params);

  Future<Chapter> deleteChapter(Chapter params);

  Future<List<University>> listUniversitys(NoParams params);

  Future<List<Institution>> listInstitutions(NoParams params);

  Future<List<Course>> listCourses(NoParams params);

  Future<Course> deleteCourse(Course params);

  Future<Course> addNewCourse(Course params);

  Future<Institution> deleteInstitution(Institution params);

  Future<Institution> addNewInstitution(Institution params);

  Future<Subject> addNewSubject(Subject params);

  Future<Subject> deleteSubject(Subject params);

  Future<Topic> addNewTopic(Topic params);

  Future<List<Topic>> listTopicss(NoParams params);

  Future<Topic> deleteTopic(Topic params);

  Future<University> deleteUniversity(University params);
}

class RemoteDataSourceImplementation implements RemoteDataSource {
  final ApiClient _apiClient;

  RemoteDataSourceImplementation(this._apiClient);

  @override
  Future<University> addUniversity(University params) async {
    final response = await _apiClient.post(ApiConstants.addUniversity);
    return University.fromJson(response);
  }

  @override
  Future<List<Chapter>> listChapters(NoParams params) async {
    final response = await _apiClient.post(ApiConstants.listChapters);
    return chapterFromJson(response);
  }

  @override
  Future<List<Subject>> listSubjects(NoParams params) async {
    final response = await _apiClient.post(ApiConstants.listSubjects);
    return subjectFromJson(response);
  }

  @override
  Future<Chapter> addNewChapter(Chapter params) async {
    final response = await _apiClient.post(ApiConstants.addNewChapter);
    return Chapter.fromJson(response);
  }

  @override
  Future<Chapter> deleteChapter(Chapter params) async {
    final response = await _apiClient.post(ApiConstants.deleteChapter);
    return Chapter.fromJson(response);
  }

  @override
  Future<List<Course>> listCourses(NoParams params) async {
    final response = await _apiClient.post(ApiConstants.listSubjects);
    return courseFromJson(response);
  }

  @override
  Future<List<Institution>> listInstitutions(NoParams params) async {
    final response = await _apiClient.post(ApiConstants.listSubjects);
    return institutionFromJson(response);
  }

  @override
  Future<List<University>> listUniversitys(NoParams params) async {
    final response = await _apiClient.post(ApiConstants.listSubjects);
    return universityFromJson(response);
  }

  @override
  Future<Course> addNewCourse(Course params) async {
    final response = await _apiClient.post(ApiConstants.addNewCourse);
    return Course.fromJson(response);
  }

  @override
  Future<Course> deleteCourse(Course params) async {
    final response = await _apiClient.post(ApiConstants.deleteCourse);
    return Course.fromJson(response);
  }

  @override
  Future<Institution> addNewInstitution(Institution params) async {
    final response = await _apiClient.post(ApiConstants.addNewInstitution);
    return Institution.fromJson(response);
  }

  @override
  Future<Institution> deleteInstitution(Institution params) async {
    final response = await _apiClient.post(ApiConstants.deleteInstitution);
    return Institution.fromJson(response);
  }

  @override
  Future<Subject> addNewSubject(Subject params) async {
    final response = await _apiClient.post(ApiConstants.addNewSubject);
    return Subject.fromJson(response);
  }

  @override
  Future<Subject> deleteSubject(Subject params) async {
    final response = await _apiClient.post(ApiConstants.deleteSubject);
    return Subject.fromJson(response);
  }

  @override
  Future<Topic> addNewTopic(Topic params) async {
    final response = await _apiClient.post(ApiConstants.addNewTopic);
    return Topic.fromJson(response);
  }

  @override
  Future<List<Topic>> listTopicss(NoParams params) async {
    final response = await _apiClient.post(ApiConstants.listAllTopic);
    return topicFromJson(response);
  }

  @override
  Future<Topic> deleteTopic(Topic params) async {
    final response = await _apiClient.post(ApiConstants.deleteTopic);
    return Topic.fromJson(response);
  }

  @override
  Future<University> deleteUniversity(University params) async {
   final response = await _apiClient.post(ApiConstants.deleteUniversity);
    return University.fromJson(response);
  }
}
