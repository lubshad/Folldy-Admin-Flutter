import 'package:dartz/dartz.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

import '../../data/models/institution_list_response.dart';

class DeleteInstitution extends UseCase<Map<String, dynamic>, Institution> {
  final DataRepository _dataRepository;

  DeleteInstitution(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(Institution params) async{
    return _dataRepository.deleteInstitution(params.toJson());
  }
}
