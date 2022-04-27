import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

class GetAllChapters extends UseCase<List<Chapter>, NoParams> {
  final DataRepository _dataRepository;

  GetAllChapters(this._dataRepository);
  @override
  Future<Either<AppError, List<Chapter>>> call(NoParams params) async {
    return _dataRepository.listChapters(params.toJson());
  }
}
