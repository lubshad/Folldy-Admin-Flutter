import 'package:dartz/dartz.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

import '../../data/models/topic_list_response.dart';

class AddNewTopic extends UseCase<Topic, Topic> {
  final DataRepository _dataRepository;

  AddNewTopic(this._dataRepository);
  @override
  Future<Either<AppError, Topic>> call(Topic params) async{
    return _dataRepository.addNewTopic(params.toJson());
  }
}
