import 'package:basic_template/basic_template.dart';
import 'package:folldy_admin/presentation/screens/areas_listing/areas_listing_controller.dart';
import 'package:folldy_admin/presentation/screens/auth_wrapper/auth_controller.dart';
import 'package:folldy_admin/presentation/screens/chapters_listing/chapter_listing_controller.dart';
import 'package:folldy_admin/presentation/screens/faculty_listing/faculties_listing_controller.dart';
import 'package:folldy_admin/presentation/screens/home_screen/home_controller.dart';
import 'package:folldy_admin/presentation/screens/presentations_listing/presentation_listing_controller.dart';
import 'package:folldy_admin/presentation/screens/subjects_listing/subjects_listing_controller.dart';
import 'package:folldy_admin/presentation/screens/user_listing/user_listing_controller.dart';
import 'package:folldy_utils/data/data_sources/remote_data_source.dart';
import 'package:folldy_utils/data/repository_implemenations/data_repository_implementation.dart';
import 'package:folldy_utils/domain/repositories/data_repository.dart';
import '../presentation/screens/courses_listing/course_listing_controller.dart';
import '../presentation/screens/universities_listing/university_listing_controller.dart';
import 'package:folldy_admin/data/core/api_constants.dart';

class DependencyInjection {
  static inject() {
    Get.lazyPut(() => ApiClient(Client(), baseUrl: ApiConstants.baseUrl));
    Get.lazyPut<RemoteDataSource>(
        () => RemoteDataSourceImplementation(Get.find()));
    Get.lazyPut<DataRepository>(() => DataRepositoryImplementation(Get.find()));
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut(() => AuthController());
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
    Get.lazyPut(
      () => AreasListingController(),
    );
    Get.lazyPut(
      () => PresentationsListingController(),
    );
    Get.lazyPut(
      () => FacultyListingController(),
    );
    Get.lazyPut(
      () => UserListingController(),
    );
  }
}
