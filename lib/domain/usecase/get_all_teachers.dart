import 'package:dartz/dartz.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

import '../../data/models/teacher_list_response.dart';

class GetAllTeachers extends UseCase<List<Teacher>, NoParams> {
  final DataRepository _dataRepository;

  GetAllTeachers(this._dataRepository);
  @override
  Future<Either<AppError, List<Teacher>>> call(NoParams params) async{
    return _dataRepository.listTeachers(params.toJson());
  }
}
