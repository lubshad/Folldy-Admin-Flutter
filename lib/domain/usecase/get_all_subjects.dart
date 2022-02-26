import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

class GetAllSubjects extends UseCase<List<Subject>, NoParams> {
  final DataRepository _dataRepository;

  GetAllSubjects(this._dataRepository);
  @override
  Future<Either<AppError, List<Subject>>> call(NoParams params) async{
    return _dataRepository.listSubjects(params.toJson());
  }
}
