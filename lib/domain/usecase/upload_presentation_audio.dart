import 'package:dartz/dartz.dart';
import 'package:folldy_admin/domain/usecase/upload_topic_images.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

import '../entities/app_error.dart';
import '../repositories/data_repository.dart';

class UploadPresentationAudio
    extends UseCase<Map<String, dynamic>, UploadFileParams> {
  final DataRepository _dataRepository;

  UploadPresentationAudio(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(
      UploadFileParams params) async {
    return _dataRepository.uploadFile(params);
  }
}