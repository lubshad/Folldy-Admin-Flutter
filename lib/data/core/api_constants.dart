class ApiConstants {
  ApiConstants._();

  static const String baseUrl = domainUrl + slugUrl;
  // static const String domainUrl = "http://64.227.131.205/";
  static const String domainUrl = "http://127.0.0.1:8000/";
  static const String slugUrl = "folldy_admin/api/";
  static const String addUniversity = "university_add";
  static const String listChapters = "chapter_list";
  static const String listSubjects = "subject_list";
  static const String universityList = "university_list";
  static const String institutionList = "instituton_list";
  static const String deleteChapter = "chapter_delete";
  static const String addNewChapter = "chapter_add";
  static const String addNewCourse = "course_add";
  static const String deleteCourse = "course_delete";
  static const String addNewInstitution = "institution_add";
  static const String deleteInstitution = "institution_delete";
  static const String addNewSubject = "subject_add";
  static const String deleteSubject = "subject_delete";
  static const String addNewTopic = "topic_add";
  static const String listAllTopic = "topic_list";
  static const String deleteTopic = "topic_delete";
  static const String deleteUniversity = "university_delete";
}
