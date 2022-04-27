import 'package:basic_template/basic_template.dart';
import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/data/models/teacher_list_response.dart';
import 'package:folldy_admin/data/models/topic_list_response.dart';

import '../../domain/repositories/data_repository.dart';
import '../data_sources/remote_data_source.dart';
import '../models/university_list_response.dart';

class DataRepositoryImplementation extends DataRepository
    with RepositoryExceptionMixin {
  final RemoteDataSource _remoteDataSource;

  DataRepositoryImplementation(this._remoteDataSource);

  @override
  Future<Either<AppError, Map<String, dynamic>>> addUniversity(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.addUniversity(params));
  }

  @override
  Future<Either<AppError, List<Chapter>>> listChapters(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.listChapters(params));
  }

  @override
  Future<Either<AppError, List<Subject>>> listSubjects(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.listSubjects(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> addNewChapter(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.addNewChapter(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> deleteChapter(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.deleteChapter(params));
  }

  @override
  Future<Either<AppError, List<Course>>> listCourses(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.listCourses(params));
  }

  @override
  Future<Either<AppError, List<Institution>>> listInstitutions(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.listInstitutions(params));
  }

  @override
  Future<Either<AppError, List<University>>> listUniversitys(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.listUniversitys(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> addNewCourse(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.addNewCourse(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> deleteCourse(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.deleteCourse(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> addNewInstitution(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.addNewInstitution(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> deleteInstitution(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.deleteInstitution(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> addNewSubject(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.addNewSubject(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> deleteSubject(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.deleteSubject(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> addNewTopic(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.addNewTopic(params));
  }

  @override
  Future<Either<AppError, List<Topic>>> listTopics(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.listTopicss(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> deleteTopic(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.deleteTopic(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> deleteUniversity(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.deleteUniversity(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> uploadFile(
      UploadFileParams params) async {
    return await exceptionHandler(_remoteDataSource.uploadFile(params));
  }

  @override
  Future<Either<AppError, List<Teacher>>> listTeachers(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.listTeachers(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> deleteTeacher(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.deleteTeacher(params));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> addNewPresentation(
      Map<String, dynamic> params) async {
    return await exceptionHandler(_remoteDataSource.addNewPresentation(params));
  }

  @override
  Future<Either<AppError, List<Area>>> listAreas(
      Map<String, dynamic> json) async {
    return await exceptionHandler(_remoteDataSource.listAreas(json));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> addNewArea(
      Map<String, dynamic> json) async {
    return await exceptionHandler(_remoteDataSource.addNewArea(json));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> deleteArea(
      Map<String, dynamic> json) async {
    return await exceptionHandler(_remoteDataSource.deleteArea(json));
  }

  @override
  Future<Either<AppError, List<Presentation>>> getAllPresentations(
      Map<String, dynamic> json) async {
    return await exceptionHandler(_remoteDataSource.getAllPresentations(json));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> deletePresentation(
      Map<String, dynamic> json) async {
    return await exceptionHandler(_remoteDataSource.deletePresentation(json));
  }
}
