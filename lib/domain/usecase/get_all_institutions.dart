import 'package:dartz/dartz.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

import '../../data/models/institution_list_response.dart';

class GetAllInstitutions extends UseCase<List<Institution>, NoParams> {
  final DataRepository _dataRepository;

  GetAllInstitutions(this._dataRepository);
  @override
  Future<Either<AppError, List<Institution>>> call(NoParams params) async{
    return _dataRepository.listInstitutions(params.toJson());
  }
}
