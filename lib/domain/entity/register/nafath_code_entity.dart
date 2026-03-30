import 'package:equatable/equatable.dart';

class NafathCodeEntity extends Equatable {
  final String? random;
  final bool? completed;

  const NafathCodeEntity({this.random, this.completed});

  @override
  List<Object?> get props => [random, completed];
}
