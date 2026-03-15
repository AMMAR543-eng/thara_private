import '../../index/index_main.dart';

class BaseEntity extends Equatable {
  final int? customStatusCode;
  final String? message;
  final bool? debug;
  final String? env;
  final AccountModel? account;
  final UserModel? user;

  const BaseEntity({
    this.customStatusCode,
    this.message,
    this.debug,
    this.env,
    this.user,
    this.account,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    customStatusCode,
    message,
    debug,
    env,
    user,
    account,
  ];
}
