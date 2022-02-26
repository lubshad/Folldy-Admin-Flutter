import 'package:dartz/dartz.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

import '../../data/models/topic_list_response.dart';

class GetAllTopics extends UseCase<List<Topic>, NoParams> {
  final DataRepository _dataRepository;

  GetAllTopics(this._dataRepository);
  @override
  Future<Either<AppError, List<Topic>>> call(NoParams params) async{
    return _dataRepository.listTopics(params);
  }
}
