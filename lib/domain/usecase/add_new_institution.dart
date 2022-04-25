import 'package:dartz/dartz.dart';
import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

import '../../data/models/institution_list_response.dart';

class AddNewInstitution extends UseCase<Map<String, dynamic>, Institution> {
  final DataRepository _dataRepository;

  AddNewInstitution(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(Institution params) async{
    return _dataRepository.addNewInstitution(params.toJson());
  }
}
