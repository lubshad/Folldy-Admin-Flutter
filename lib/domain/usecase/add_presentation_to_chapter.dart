import 'dart:convert';

import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

class AddPresentationToChapter
    extends UseCase<dynamic, AddPresentaionChapterParams> {
  final DataRepository _dataRepository;

  AddPresentationToChapter(this._dataRepository);
  @override
  Future<Either<AppError, dynamic>> call(
      AddPresentaionChapterParams params) async {
    return _dataRepository.addPresentationsToChapter(params.toMap());
  }
}

class AddPresentaionChapterParams {
  final List<int> presentationIds;
  final int chapterId;

  AddPresentaionChapterParams(
      {required this.presentationIds, required this.chapterId});

  Map<String, dynamic> toMap() {
    return {
      'presentationIds': presentationIds,
      'chapterId': chapterId,
    };
  }

  factory AddPresentaionChapterParams.fromMap(Map<String, dynamic> map) {
    return AddPresentaionChapterParams(
      presentationIds: List<int>.from(map['presentationIds']),
      chapterId: map['chapterId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddPresentaionChapterParams.fromJson(String source) =>
      AddPresentaionChapterParams.fromMap(json.decode(source));
}
