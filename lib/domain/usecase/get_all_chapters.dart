import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

class GetAllChapters extends UseCase<List<Chapter>, NoParams> {
  final DataRepository _dataRepository;

  GetAllChapters(this._dataRepository);
  @override
  Future<Either<AppError, List<Chapter>>> call(NoParams params) async{
    return _dataRepository.listChapters(params);
  }
}
