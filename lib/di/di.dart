

import 'package:get/get.dart';
import 'package:http/http.dart';

import '../data/core/api_client.dart';
import '../data/data_sources/remote_data_source.dart';
import '../data/repository_implemenations/data_repository_implementation.dart';
import '../domain/repositories/data_repository.dart';

class DependencyInjection {
  static inject() {
    Get.lazyPut(() => ApiClient(Client()));
    Get.lazyPut<RemoteDataSource>(
        () => RemoteDataSourceImplementation(Get.find()));
    Get.lazyPut<DataRepository>(() => DataRepositoryImplementation(Get.find()));
   
  }
}
