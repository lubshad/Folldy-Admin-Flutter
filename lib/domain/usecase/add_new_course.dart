import 'dart:convert';

import 'package:basic_template/basic_template.dart';
import 'package:folldy_admin/domain/repositories/data_repository.dart';

class AddNewCourse extends UseCase<Map<String, dynamic>, AddCourseParams> {
  final DataRepository _dataRepository;

  AddNewCourse(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(AddCourseParams params) async {
    return _dataRepository.addNewCourse(params.toMap());
  }
}


class AddCourseParams {
  final String name;
  final int university;
  final int? id;

  AddCourseParams({required this.name, required this.university, required this.id});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'university': university,
      'id': id,
    };
  }

  factory AddCourseParams.fromMap(Map<String, dynamic> map) {
    return AddCourseParams(
      name: map['name'] ?? '',
      university: map['university']?.toInt() ?? 0,
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddCourseParams.fromJson(String source) => AddCourseParams.fromMap(json.decode(source));
}
