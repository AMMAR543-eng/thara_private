import 'package:thara/Domain/entity/register/answers_entity.dart';

class AnswersModel extends AnswersEntity {
  const AnswersModel({final int? id, final String? answer})
    : super(id: id, answer: answer);

  factory AnswersModel.fromJson(Map<String, dynamic> json) {
    return AnswersModel(
      id: json['id'] as int?,
      answer: json['answer'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'answer': answer};
  }
}
