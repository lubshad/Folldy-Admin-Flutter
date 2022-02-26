import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType appErrorType;

  const AppError(this.appErrorType);

  @override
  List<Object> get props => [appErrorType];

  handleError() {
  }


  
}

enum AppErrorType { api, network, database, unauthorised, sessionDenied }
