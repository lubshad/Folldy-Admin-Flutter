import 'package:dartz/dartz.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

import '../../data/models/university_list_response.dart';

class DeleteUniversity extends UseCase<Map<String, dynamic>, University> {
  final DataRepository _dataRepository;

  DeleteUniversity(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(University params) async {
    return _dataRepository.deleteUniversity(params.toJson());
  }
}
