import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/data/models/topic_details_response.dart';
import 'package:folldy_admin/data/models/topic_list_response.dart';
import 'package:folldy_admin/data/models/university_list_response.dart';
import 'package:folldy_admin/domain/usecase/upload_topic_images.dart';

import '../core/api_client.dart';
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

  Future<Map<String, dynamic>> uploadImages(UploadImageParams params);

  Future<TopicDetailsResponse> getTopicDetails(Map<String, dynamic> params);
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
    return topicFromJson(response);
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
  Future<Map<String, dynamic>> uploadImages(UploadImageParams params) async {
    final response = await _apiClient.formData(
        data: params.data, files: params.images, path: params.path);
    return response;
  }

  @override
  Future<TopicDetailsResponse> getTopicDetails(Map<String, dynamic> params) async {
    final response =
        await _apiClient.post(ApiConstants.topicDetails, params);
    return TopicDetailsResponse.fromJson(response);
  }


}
