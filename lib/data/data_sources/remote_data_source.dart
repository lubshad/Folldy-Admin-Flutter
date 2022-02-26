

import '../core/api_client.dart';

abstract class RemoteDataSource {
}

class RemoteDataSourceImplementation implements RemoteDataSource {
  final ApiClient _apiClient;

  RemoteDataSourceImplementation(this._apiClient);
}
