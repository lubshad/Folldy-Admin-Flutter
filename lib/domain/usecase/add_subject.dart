import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

class AddNewSubject extends UseCase<Map<String, dynamic>, Subject> {
  final DataRepository _dataRepository;

  AddNewSubject(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(Subject params) async {
    return _dataRepository.addNewSubject(params.toJson());
  }
}
