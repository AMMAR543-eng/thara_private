import 'package:equatable/equatable.dart';

class AnswersEntity extends Equatable {
  final int? id;
  final String? answer;

  const AnswersEntity({this.id, this.answer});

  @override
  List<Object?> get props => [id, answer];
}
