import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

class DeleteSubject extends UseCase<Map<String, dynamic>, Subject> {
  final DataRepository _dataRepository;

  DeleteSubject(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(Subject params) async{
    return _dataRepository.deleteSubject(params.toJson());
  }
}
