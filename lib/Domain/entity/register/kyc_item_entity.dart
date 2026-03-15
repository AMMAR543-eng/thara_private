import 'package:equatable/equatable.dart';
import 'package:thara/Domain/entity/register/answers_entity.dart';

class KycItemEntity extends Equatable {
  final int? id;
  final String? type;
  final String? category;
  final String? question;
  final String? textAnswer;
  final String? numberAnswer;
  final String? boolAnswer;
  final String? file;
  final List<AnswersEntity?>? answers;
  final List<KycItemEntity?>? children;
  final List<dynamic>? parentAnswerChildDependOn;

  const KycItemEntity({
    this.id,
    this.type,
    this.category,
    this.question,
    this.answers,
    this.children,
    this.parentAnswerChildDependOn,
    this.textAnswer,
    this.numberAnswer,
    this.boolAnswer,
    this.file,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    category,
    question,
    answers,
    children,
    parentAnswerChildDependOn,
    textAnswer,
    numberAnswer,
    boolAnswer,
    file,
  ];
}
