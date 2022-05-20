import 'package:folldy_admin/data/core/api_constants.dart';
import 'package:basic_template/basic_template.dart';
import 'package:folldy_admin/presentation/screens/chapters_listing/chapter_listing_controller.dart';
import 'package:folldy_admin/presentation/screens/subjects_listing/subjects_listing_controller.dart';

import '../data/data_sources/remote_data_source.dart';
import '../data/repository_implemenations/data_repository_implementation.dart';
import '../domain/repositories/data_repository.dart';
import '../presentation/screens/courses_listing/course_listing_controller.dart';
import '../presentation/screens/universities_listing/university_listing_controller.dart';

class DependencyInjection {
  static inject() {
    Get.lazyPut(() => ApiClient(Client(), baseUrl: ApiConstants.baseUrl));
    Get.lazyPut<RemoteDataSource>(
        () => RemoteDataSourceImplementation(Get.find()));
    Get.lazyPut<DataRepository>(() => DataRepositoryImplementation(Get.find()));
    Get.lazyPut(
      () => CourseListingController(),
    );
    Get.lazyPut(
      () => UniversityListingController(),
    );
    Get.lazyPut(
      () => SubjectListingController(),
    );
    Get.lazyPut(
      () => ChapterListingController(),
    );
  }
}
