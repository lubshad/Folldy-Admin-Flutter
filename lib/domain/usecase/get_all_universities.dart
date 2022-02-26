import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/university_list_response.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

class GetAllUniversitys extends UseCase<List<University>, NoParams> {
  final DataRepository _dataRepository;

  GetAllUniversitys(this._dataRepository);
  @override
  Future<Either<AppError, List<University>>> call(NoParams params) async{
    return _dataRepository.listUniversitys(params);
  }
}
