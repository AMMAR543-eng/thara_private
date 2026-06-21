import '../../entity/register/kyc_item_entity.dart';

class KycParam {
  final List<KycItemEntity>? questions;

  KycParam({required this.questions});

  factory KycParam.fromJson(Map<String, dynamic> json) {
    return KycParam(questions: json['questions'] ?? '');
  }

  Map<String, String> extractFiles() {
    final Map<String, String> files = {};

    if (questions == null || questions!.isEmpty) return files;

    for (int i = 0; i < questions!.length; i++) {
      final question = questions![i];
      if (question.type == 'file' && question.file != null) {
        files['answers[$i][file]'] = question.file!;
      }
    }

    return files;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (questions == null || questions!.isEmpty) return data;

    for (int i = 0; i < questions!.length; i++) {
      final question = questions![i];

      data['answers[$i][question_id]'] = question.id;
      data['answers[$i][category]'] = question.category;
      data['answers[$i][question_type]'] = question.type;

      switch (question.type) {
        case 'multi_choice':
        case 'single_choice':
          final answersList = question.answers;
          if (answersList != null && answersList.isNotEmpty) {
            for (int j = 0; j < answersList.length; j++) {
              final answer = answersList[j];
              if (answer?.id != null) {
                data['answers[$i][answer_ids][$j]'] = answer!.id;
              }
            }
          }
          break;

        case 'bool':
          if (question.boolAnswer != null) {
            data['answers[$i][bool_answer]'] = question.boolAnswer;
          }
          break;

        case 'text':
          if (question.textAnswer != null) {
            data['answers[$i][text_answer]'] = question.textAnswer;
          }
          break;

        case 'number':
          if (question.numberAnswer != null) {
            data['answers[$i][number_answer]'] = question.numberAnswer;
          }
          break;

        case 'file':
          if (question.file != null) {
            data['answers[$i][file]'] = question.file;
          }
          break;
      }
    }

    return data;
  }
}
