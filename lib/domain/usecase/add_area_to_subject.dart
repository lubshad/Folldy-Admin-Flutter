// import 'dart:convert';

// import 'package:basic_template/basic_template.dart';

// import 'package:folldy_admin/domain/repositories/data_repository.dart';

// class AddAreaToSubject extends UseCase<dynamic, AddAreaSubjectParams> {
//   final DataRepository _dataRepository;

//   AddAreaToSubject(this._dataRepository);
//   @override
//   Future<Either<AppError, dynamic>> call(AddAreaSubjectParams params) async {
//     return _dataRepository.addAreaToSubject(params.toMap());
//   }
// }

// class AddAreaSubjectParams {
//   final List<int> areaIds;
//   final int subjectId;
//   AddAreaSubjectParams({required this.subjectId, this.areaIds = const []});

//   Map<String, dynamic> toMap() {
//     return {
//       'areaIds': areaIds,
//       'subjectId': subjectId,
//     };
//   }

//   factory AddAreaSubjectParams.fromMap(Map<String, dynamic> map) {
//     return AddAreaSubjectParams(
//       areaIds: List<int>.from(map['areaIds']),
//       subjectId: map['subjectId']?.toInt() ?? 0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory AddAreaSubjectParams.fromJson(String source) =>
//       AddAreaSubjectParams.fromMap(json.decode(source));
// }
