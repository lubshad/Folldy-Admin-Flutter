import 'package:folldy_admin/data/models/university_list_response.dart';
import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

class AddNewUniversity extends UseCase<Map<String, dynamic>, University> {
  final DataRepository _dataRepository;

  AddNewUniversity(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(University params) async {
    return _dataRepository.addUniversity(params.toJson());
  }
}
