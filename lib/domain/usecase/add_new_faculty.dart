import 'dart:convert';

import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/repositories/data_repository.dart';

class AddNewFaculty extends UseCase<Map<String, dynamic>, AddFacultyParams> {
  final DataRepository _dataRepository;

  AddNewFaculty(this._dataRepository);
  @override
  Future<Either<AppError, Map<String, dynamic>>> call(
      AddFacultyParams params) async {
    return _dataRepository.addFaculty(params.toMap());
  }
}

class AddFacultyParams {
  final String name;
  final String phone;
  final int? id;

  AddFacultyParams({required this.name, required this.phone, this.id});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'id': id,
    };
  }

  factory AddFacultyParams.fromMap(Map<String, dynamic> map) {
    return AddFacultyParams(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddFacultyParams.fromJson(String source) =>
      AddFacultyParams.fromMap(json.decode(source));
}
