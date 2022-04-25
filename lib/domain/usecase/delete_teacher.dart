import 'package:dartz/dartz.dart';
import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

import '../../data/models/teacher_list_response.dart';

class DeleteTeacher extends UseCase<Map<String, dynamic>, Teacher> {
  final DataRepository _dataRepository;

  DeleteTeacher(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(Teacher params) async {
    return _dataRepository.deleteTeacher(params.toJson());
  }
}
