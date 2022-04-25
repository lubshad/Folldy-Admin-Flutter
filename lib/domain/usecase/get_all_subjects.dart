import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

class GetAllSubjects extends UseCase<List<Subject>, NoParams> {
  final DataRepository _dataRepository;

  GetAllSubjects(this._dataRepository);
  @override
  Future<Either<AppError, List<Subject>>> call(NoParams params) async {
    return _dataRepository.listSubjects(params.toJson());
  }
}
