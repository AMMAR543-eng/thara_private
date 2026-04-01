import '../../../index/index_main.dart';

class KycItemModel extends KycItemEntity {
  KycItemModel({
    int? id,
    String? type,
    String? category,
    String? question,
    String? textAnswer,
    String? numberAnswer,
    String? boolAnswer,
    String? file,
    List<AnswersModel?>? answers,
    List<KycItemModel?>? children,
    List<dynamic>? parentAnswerChildDependOn,
  }) : super(
          id: id,
          type: type,
          category: category,
          question: question,
          answers: answers,
          children: children,
          parentAnswerChildDependOn: parentAnswerChildDependOn,
          textAnswer: textAnswer,
          numberAnswer: numberAnswer,
          boolAnswer: boolAnswer,
          file: file,
        );

  factory KycItemModel.fromJson(Map<String, dynamic> json) {
    return KycItemModel(
      id: json['id'] as int?,
      type: json['type'] as String?,
      category: json['category'] as String?,
      question: json['question'] as String?,
      textAnswer: json['text_answer'] as String?,
      numberAnswer: json['number_answer'] as String?,
      boolAnswer: json['bool_answer'] as String?,
      file: json['file'] as String?,
      answers: (json['answers'] as List)
          .map((item) => AnswersModel.fromJson(item))
          .toList(),
      children: json['children'] != null
          ? (json['children'] as List)
              .map((item) => KycItemModel.fromJson(item))
              .toList()
          : null,
      parentAnswerChildDependOn: json['parentAnswerChildDependOn'] != null
          ? (json['parentAnswerChildDependOn'] as List<dynamic>?)!
              .map((e) => e)
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'category': category,
      'question': question,
      'answers': answers,
      'children': children,
      'parentAnswerChildDependOn': parentAnswerChildDependOn,
      'text_answer': textAnswer,
      'number_answer': numberAnswer,
      'bool_answer': boolAnswer,
      'file': file,
    };
  }
}
