import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/data/models/topic_list_response.dart';

import '../../domain/entities/app_error.dart';
import '../../domain/repositories/data_repository.dart';
import '../data_sources/remote_data_source.dart';
import '../models/university_list_response.dart';

class DataRepositoryImplementation extends DataRepository {
  final RemoteDataSource _remoteDataSource;

  DataRepositoryImplementation(this._remoteDataSource);

  @override
  Future<Either<AppError, University>> addUniversity(
      Map<String, dynamic> params) async {
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
  Future<Either<AppError, List<Chapter>>> listChapters(
      Map<String, dynamic> params) async {
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
  Future<Either<AppError, List<Subject>>> listSubjects(
      Map<String, dynamic> params) async {
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
  Future<Either<AppError, Chapter>> addNewChapter(
      Map<String, dynamic> params) async {
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
  Future<Either<AppError, Chapter>> deleteChapter(
      Map<String, dynamic> params) async {
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
  Future<Either<AppError, List<Course>>> listCourses(
      Map<String, dynamic> params) async {
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
      Map<String, dynamic> params) async {
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
      Map<String, dynamic> params) async {
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
  Future<Either<AppError, Course>> addNewCourse(
      Map<String, dynamic> params) async {
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
  Future<Either<AppError, Course>> deleteCourse(
      Map<String, dynamic> params) async {
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
      Map<String, dynamic> params) async {
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
      Map<String, dynamic> params) async {
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
  Future<Either<AppError, Subject>> addNewSubject(
      Map<String, dynamic> params) async {
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
  Future<Either<AppError, Subject>> deleteSubject(
      Map<String, dynamic> params) async {
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
  Future<Either<AppError, Topic>> addNewTopic(
      Map<String, dynamic> params) async {
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
  Future<Either<AppError, List<Topic>>> listTopics(
      Map<String, dynamic> params) async {
    try {
      List<Topic> response = await _remoteDataSource.listTopicss(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, Topic>> deleteTopic(
      Map<String, dynamic> params) async {
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
  Future<Either<AppError, Map<String, dynamic>>> deleteUniversity(
      Map<String, dynamic> params) async {
    try {
      final response = await _remoteDataSource.deleteUniversity(params);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
