import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

class GetAllCourses extends UseCase<List<Course>, NoParams> {
  final DataRepository _dataRepository;

  GetAllCourses(this._dataRepository);
  @override
  Future<Either<AppError, List<Course>>> call(NoParams params) async {
    return _dataRepository.listCourses(params.toJson());
  }
}
