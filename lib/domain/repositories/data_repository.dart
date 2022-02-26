import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/data/models/topic_list_response.dart';
import 'package:folldy_admin/data/models/university_list_response.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';

abstract class DataRepository {
  Future<Either<AppError, University>> addUniversity(University params);

  Future<Either<AppError, List<Chapter>>> listChapters(NoParams params);
  Future<Either<AppError, List<Subject>>> listSubjects(NoParams params);

  Future<Either<AppError, Chapter>> addNewChapter(Chapter params);

  Future<Either<AppError, Chapter>> deleteChapter(Chapter params);

  Future<Either<AppError, List<University>>> listUniversitys(NoParams params);

  Future<Either<AppError, List<Institution>>> listInstitutions(NoParams params);

  Future<Either<AppError, List<Course>>> listCourses(NoParams params);

  Future<Either<AppError, Course>> deleteCourse(Course params);

  Future<Either<AppError, Course>> addNewCourse(Course params);

  Future<Either<AppError, Institution>> addNewInstitution(Institution params);

  Future<Either<AppError, Institution>> deleteInstitution(Institution params);

  Future<Either<AppError, Subject>> deleteSubject(Subject params);

  Future<Either<AppError, Subject>> addNewSubject(Subject params);

  Future<Either<AppError, List<Topic>>> listTopics(NoParams params);

  Future<Either<AppError, Topic>> addNewTopic(Topic params);

  Future<Either<AppError, Topic>> deleteTopic(Topic params);

  Future<Either<AppError, University>> deleteUniversity(University params);
}
