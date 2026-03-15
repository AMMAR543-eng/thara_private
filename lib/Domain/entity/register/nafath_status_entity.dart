import 'package:equatable/equatable.dart';

class NafathStatusEntity extends Equatable {
  final String? status;
  final bool? completed;

  const NafathStatusEntity({this.status, this.completed});

  @override
  List<Object?> get props => [status, completed];
}
