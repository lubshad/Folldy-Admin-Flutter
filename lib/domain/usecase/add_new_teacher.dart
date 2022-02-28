import 'package:dartz/dartz.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/upload_topic_images.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

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
