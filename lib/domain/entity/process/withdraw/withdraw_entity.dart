import 'package:equatable/equatable.dart';
import 'bank_account_entity.dart';

class WithdrawEntity extends Equatable {
  final String? id;
  final String? status;
  final String? transferringStatus;
  final String? amount;
  final BankAccountEntity? bankAccount;
  final String? createdAt;

  const WithdrawEntity({
    this.id,
    this.status,
    this.transferringStatus,
    this.amount,
    this.bankAccount,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        transferringStatus,
        amount,
        bankAccount,
        createdAt,
      ];
}
