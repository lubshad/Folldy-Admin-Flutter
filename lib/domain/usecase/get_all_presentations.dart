import 'package:basic_template/basic_template.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';

class PresentationListingParams {
  final String? searchKey;
  PresentationListingParams({
    this.searchKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'searchKey': searchKey?? '',
    };
  }

  factory PresentationListingParams.fromMap(Map<String, dynamic> map) {
    return PresentationListingParams(
      searchKey: map['searchKey'],
    );
  }
}

class GetAllPresentations
    extends UseCase<List<Presentation>, PresentationListingParams> {
  final DataRepository _dataRepository;

  GetAllPresentations(this._dataRepository);
  @override
  Future<Either<AppError, List<Presentation>>> call(
      PresentationListingParams params) async {
    return _dataRepository.getAllPresentations(params.toMap());
  }
}
