import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

import '../../data/models/course_list_response.dart';

class AddNewCourse extends UseCase<Map<String, dynamic>, Course> {
  final DataRepository _dataRepository;

  AddNewCourse(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(Course params) async {
    return _dataRepository.addNewCourse(params.toJson());
  }
}
