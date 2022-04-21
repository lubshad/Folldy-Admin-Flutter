import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

class AddNewArea extends UseCase<Map<String, dynamic>, Area> {
  final DataRepository _dataRepository;

  AddNewArea(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(Area params) async {
    return _dataRepository.addNewArea(params.toJson());
  }
}
