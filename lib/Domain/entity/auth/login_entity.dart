import 'package:equatable/equatable.dart';

import '../../../index/index_main.dart';

class LoginEntity extends Equatable {
  final String? accessToken;

  const LoginEntity({this.accessToken});

  @override
  List<Object?> get props => [accessToken];
}
