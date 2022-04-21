import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

class DeletePresentation extends UseCase<Map<String, dynamic>, Presentation> {
  final DataRepository _dataRepository;

  DeletePresentation(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(
      Presentation params) async {
    return _dataRepository.deletePresentation(params.toJson());
  }
}
