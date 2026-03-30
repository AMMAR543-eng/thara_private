import 'package:equatable/equatable.dart';

class DepositeEntity extends Equatable {
  final String? amount;
  final String? sourceIban;
  final bool? knownSource;
  final String? date;
  final String? ref;

  const DepositeEntity({
    this.amount,
    this.sourceIban,
    this.knownSource,
    this.date,
    this.ref,
  });

  @override
  List<Object?> get props => [amount, sourceIban, knownSource, date, ref];
}
