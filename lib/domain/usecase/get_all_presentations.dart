import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

class GetAllPresentations extends UseCase<List<Presentation>, NoParams> {
  final DataRepository _dataRepository;

  GetAllPresentations(this._dataRepository);
  @override
  Future<Either<AppError, List<Presentation>>> call(NoParams params) async {
    return _dataRepository.getAllPresentations(params.toJson());
  }
}
