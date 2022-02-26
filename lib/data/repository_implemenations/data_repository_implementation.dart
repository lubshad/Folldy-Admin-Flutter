import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/data/models/topic_list_response.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/data/models/chapter_list_response.dart';

import '../../domain/entities/app_error.dart';
import '../../domain/repositories/data_repository.dart';
import '../data_sources/remote_data_source.dart';
import '../models/university_list_response.dart';
import 'dart:io';

class DataRepositoryImplementation extends DataRepository {
  final RemoteDataSource _remoteDataSource;

  DataRepositoryImplementation(this._remoteDataSource);

  @override
  Future<Either<AppError, University>> addUniversity(University params) async {
    try {
      final response = await _remoteDataSource.addUniversity(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<Chapter>>> listChapters(NoParams params) async {
    try {
      List<Chapter> response = await _remoteDataSource.listChapters(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<Subject>>> listSubjects(NoParams params) async {
    try {
      List<Subject> response = await _remoteDataSource.listSubjects(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, Chapter>> addNewChapter(Chapter params) async {
    try {
      Chapter response = await _remoteDataSource.addNewChapter(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, Chapter>> deleteChapter(Chapter params) async {
    try {
      Chapter response = await _remoteDataSource.deleteChapter(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<Course>>> listCourses(NoParams params) async {
    try {
      List<Course> response = await _remoteDataSource.listCourses(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<Institution>>> listInstitutions(
      NoParams params) async {
    try {
      List<Institution> response =
          await _remoteDataSource.listInstitutions(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<University>>> listUniversitys(
      NoParams params) async {
    try {
      List<University> response =
          await _remoteDataSource.listUniversitys(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, Course>> addNewCourse(Course params) async {
    try {
      Course response = await _remoteDataSource.addNewCourse(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, Course>> deleteCourse(Course params) async {
    try {
      Course response = await _remoteDataSource.deleteCourse(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, Institution>> addNewInstitution(
      Institution params) async {
    try {
      Institution response = await _remoteDataSource.addNewInstitution(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, Institution>> deleteInstitution(
      Institution params) async {
    try {
      Institution response = await _remoteDataSource.deleteInstitution(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, Subject>> addNewSubject(Subject params) async {
    try {
      Subject response = await _remoteDataSource.addNewSubject(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, Subject>> deleteSubject(Subject params) async {
    try {
      Subject response = await _remoteDataSource.deleteSubject(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, Topic>> addNewTopic(Topic params) async {
    try {
      Topic response = await _remoteDataSource.addNewTopic(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<Topic>>> listTopics(NoParams params) async {
    try {
      List<Topic> response =
          await _remoteDataSource.listTopicss(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, Topic>> deleteTopic(Topic params) async {
    try {
      Topic response = await _remoteDataSource.deleteTopic(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, University>> deleteUniversity(University params) async {
    try {
      University response = await _remoteDataSource.deleteUniversity(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
