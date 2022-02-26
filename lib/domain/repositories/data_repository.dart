import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/data/models/topic_list_response.dart';
import 'package:folldy_admin/data/models/university_list_response.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';

abstract class DataRepository {
  Future<Either<AppError, University>> addUniversity(
      Map<String, dynamic> params);

  Future<Either<AppError, List<Chapter>>> listChapters(
      Map<String, dynamic> params);
  Future<Either<AppError, List<Subject>>> listSubjects(
      Map<String, dynamic> params);

  Future<Either<AppError, Chapter>> addNewChapter(Map<String, dynamic> params);

  Future<Either<AppError, Chapter>> deleteChapter(Map<String, dynamic> params);

  Future<Either<AppError, List<University>>> listUniversitys(
      Map<String, dynamic> params);

  Future<Either<AppError, List<Institution>>> listInstitutions(
      Map<String, dynamic> params);

  Future<Either<AppError, List<Course>>> listCourses(
      Map<String, dynamic> params);

  Future<Either<AppError, Course>> deleteCourse(Map<String, dynamic> params);

  Future<Either<AppError, Course>> addNewCourse(Map<String, dynamic> params);

  Future<Either<AppError, Institution>> addNewInstitution(
      Map<String, dynamic> params);

  Future<Either<AppError, Institution>> deleteInstitution(
      Map<String, dynamic> params);

  Future<Either<AppError, Subject>> deleteSubject(Map<String, dynamic> params);

  Future<Either<AppError, Subject>> addNewSubject(Map<String, dynamic> params);

  Future<Either<AppError, List<Topic>>> listTopics(Map<String, dynamic> params);

  Future<Either<AppError, Topic>> addNewTopic(Map<String, dynamic> params);

  Future<Either<AppError, Topic>> deleteTopic(Map<String, dynamic> params);

  Future<Either<AppError, Map<String, dynamic>>> deleteUniversity(
      Map<String, dynamic> params);
}
