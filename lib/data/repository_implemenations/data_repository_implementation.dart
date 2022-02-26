import 'dart:io';

import '../../domain/repositories/data_repository.dart';
import '../remote_data_source.dart';

class DataRepositoryImplementation extends DataRepository {
  final RemoteDataSource _remoteDataSource;

  DataRepositoryImplementation(this._remoteDataSource);
}
