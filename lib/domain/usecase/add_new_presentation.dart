import 'package:dartz/dartz.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

import '../../data/models/topic_details_response.dart';

class AddNewPresentation extends UseCase<Map<String, dynamic>, Presentation> {
  final DataRepository _dataRepository;

  AddNewPresentation(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(
      Presentation params) async {
    return _dataRepository.addNewPresentation(params.toJson());
  }
}

// class Presentation {
//   final int id;
//   final int teacher;
//   final int topic;

//   Presentation({required this.id, required this.teacher, required this.topic});

//   toJson() {
//     return {
//       'id': id,
//       'teacher': teacher,
//       'topic': topic,
//     };
//   }
// }
