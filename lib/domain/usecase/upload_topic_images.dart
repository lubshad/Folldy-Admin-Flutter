
import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';
class UploadTopicImages
    extends UseCase<Map<String, dynamic>, UploadFileParams> {
  final DataRepository _dataRepository;

  UploadTopicImages(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(
      UploadFileParams params) async {
    return _dataRepository.uploadFile(params);
  }
}
