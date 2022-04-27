import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

class AddNewArea extends UseCase<Map<String, dynamic>, Area> {
  final DataRepository _dataRepository;

  AddNewArea(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(Area params) async {
    return _dataRepository.addNewArea(params.toJson());
  }
}
