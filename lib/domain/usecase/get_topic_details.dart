import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/topic_details_response.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

import '../../data/models/topic_list_response.dart';

class GetTopicDetails extends UseCase<TopicDetailsResponse, Topic> {
  final DataRepository _dataRepository;

  GetTopicDetails(this._dataRepository);
  @override
  Future<Either<AppError, TopicDetailsResponse>> call(Topic params) async{
    return _dataRepository.getTopicDetails(params.toJson());
  }
}
