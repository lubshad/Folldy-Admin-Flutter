import 'package:dartz/dartz.dart';
import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:folldy_admin/domain/entities/app_error.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';
import 'package:folldy_admin/domain/usecase/usecase.dart';

class AddNewChapter extends UseCase<Chapter, Chapter> {
  final DataRepository _dataRepository;

  AddNewChapter(this._dataRepository);
  @override
  Future<Either<AppError, Chapter>> call(Chapter params) async{
    return _dataRepository.addNewChapter(params.toJson());
  }
}
