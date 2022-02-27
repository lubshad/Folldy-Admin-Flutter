import 'package:dartz/dartz.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';
import 'package:http/http.dart';

class UploadTopicImages
    extends UseCase<Map<String, dynamic>, UploadImageParams> {
  final DataRepository _dataRepository;

  UploadTopicImages(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(
      UploadImageParams params) async {
    return _dataRepository.uploadImages(params);
  }
}

class UploadImageParams {
  final Map<String, dynamic> data;
  final List<MultipartFile> images;
  final String path;

  UploadImageParams(this.data, this.images, this.path);
}
