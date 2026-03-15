import 'package:equatable/equatable.dart';
import 'package:thara/Data/Models/user_account/account_model.dart';

class AppError extends Equatable {
  final String messege;
   AccountModel? account;
   AppError(this.messege,{this.account});

  @override
  // TODO: implement props
  List<Object?> get props => [messege];
}
