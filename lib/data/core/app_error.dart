import 'package:thara/index/index_main.dart';

class AppError extends Equatable {
  final String messege;
  AccountModel? account;

  AppError(this.messege, {this.account});

  @override
  // TODO: implement props
  List<Object?> get props => [messege];
}
