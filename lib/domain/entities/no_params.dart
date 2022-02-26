import 'package:equatable/equatable.dart';

class NoParams extends Equatable {
  @override
  List<Object> get props => [];

  Map<String, dynamic> toJson() {
    return {"session": "session"};
  }
}
