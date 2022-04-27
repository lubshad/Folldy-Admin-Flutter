
import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

class AddNewTeacher
    extends UseCase<Map<String, dynamic>, UploadFileParams> {
  final DataRepository _dataRepository;

  AddNewTeacher(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(
      UploadFileParams params) async {
    return _dataRepository.uploadFile(params);
  }
}
