import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/data/models/topic_list_response.dart';
import 'package:folldy_admin/data/models/university_list_response.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';

abstract class DataRepository {
  Future<Either<AppError, Map<String, dynamic>>> addUniversity(
      Map<String, dynamic> params);

  Future<Either<AppError, List<Chapter>>> listChapters(
      Map<String, dynamic> params);
  Future<Either<AppError, List<Subject>>> listSubjects(
      Map<String, dynamic> params);

  Future<Either<AppError, Map<String, dynamic>>> addNewChapter(Map<String, dynamic> params);

  Future<Either<AppError, Map<String, dynamic>>> deleteChapter(Map<String, dynamic> params);

  Future<Either<AppError, List<University>>> listUniversitys(
      Map<String, dynamic> params);

  Future<Either<AppError, List<Institution>>> listInstitutions(
      Map<String, dynamic> params);

  Future<Either<AppError, List<Course>>> listCourses(
      Map<String, dynamic> params);

  Future<Either<AppError, Map<String, dynamic>>> deleteCourse(Map<String, dynamic> params);

  Future<Either<AppError, Map<String, dynamic>>> addNewCourse(Map<String, dynamic> params);

  Future<Either<AppError, Map<String, dynamic>>> addNewInstitution(
      Map<String, dynamic> params);

  Future<Either<AppError, Map<String, dynamic>>> deleteInstitution(
      Map<String, dynamic> params);

  Future<Either<AppError, Map<String, dynamic>>> deleteSubject(Map<String, dynamic> params);

  Future<Either<AppError, Map<String, dynamic>>> addNewSubject(Map<String, dynamic> params);

  Future<Either<AppError, List<Topic>>> listTopics(Map<String, dynamic> params);

  Future<Either<AppError, Map<String, dynamic>>> addNewTopic(Map<String, dynamic> params);

  Future<Either<AppError, Map<String, dynamic>>> deleteTopic(Map<String, dynamic> params);

  Future<Either<AppError, Map<String, dynamic>>> deleteUniversity(
      Map<String, dynamic> params);
}
