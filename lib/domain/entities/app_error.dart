import 'package:equatable/equatable.dart';
import 'package:folldy_admin/utils/utils.dart';

class AppError extends Equatable {
  final AppErrorType appErrorType;

  const AppError(this.appErrorType);

  @override
  List<Object> get props => [appErrorType];

  handleError() {
    consolelog(appErrorType);
  }
}

enum AppErrorType { api, network, database, unauthorised, sessionDenied }
