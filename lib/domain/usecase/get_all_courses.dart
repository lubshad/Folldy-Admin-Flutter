import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

class GetAllCourses extends UseCase<List<Course>, NoParams> {
  final DataRepository _dataRepository;

  GetAllCourses(this._dataRepository);
  @override
  Future<Either<AppError, List<Course>>> call(NoParams params) async{
    return _dataRepository.listCourses(params);
  }
}
