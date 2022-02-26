import 'package:dartz/dartz.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

import '../../data/models/course_list_response.dart';

class DeleteCourse extends UseCase<Map<String, dynamic>, Course> {
  final DataRepository _dataRepository;

  DeleteCourse(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(Course params) async {
    return _dataRepository.deleteCourse(params.toJson());
  }
}
