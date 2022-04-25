import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

class GetAllAreas extends UseCase<List<Area>, NoParams> {
  final DataRepository _dataRepository;

  GetAllAreas(this._dataRepository);
  @override
  Future<Either<AppError, List<Area>>> call(NoParams params) async {
    return _dataRepository.listAreas(params.toJson());
  }
}
