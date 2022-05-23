import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

import '../../data/models/faculty_list_response.dart';

class GetAllFacultys extends UseCase<List<Faculty>, NoParams> {
  final DataRepository _dataRepository;

  GetAllFacultys(this._dataRepository);
  @override
  Future<Either<AppError, List<Faculty>>> call(NoParams params) async {
    return _dataRepository.listFacultys(params.toJson());
  }
}
