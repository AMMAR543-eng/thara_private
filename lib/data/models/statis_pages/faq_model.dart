class FaqsResponseModel {
  final FaqsData? data;
  final int? customStatusCode;
  final String? message;
  final bool? debug;
  final String? env;

  FaqsResponseModel({
    this.data,
    this.customStatusCode,
    this.message,
    this.debug,
    this.env,
  });

  factory FaqsResponseModel.fromJson(Map<String, dynamic> json) {
    return FaqsResponseModel(
      data: json['data'] != null ? FaqsData.fromJson(json['data']) : null,
      customStatusCode: json['customStatusCode'],
      message: json['message'],
      debug: json['debug'],
      env: json['env'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'customStatusCode': customStatusCode,
      'message': message,
      'debug': debug,
      'env': env,
    };
  }
}

class FaqsData {
  final Map<String, FaqCategory>? faqs;

  FaqsData({this.faqs});

  factory FaqsData.fromJson(Map<String, dynamic> json) {
    final faqsJson = json['faqs'] as Map<String, dynamic>?;
    return FaqsData(
      faqs: faqsJson
          ?.map((key, value) => MapEntry(key, FaqCategory.fromJson(value))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'faqs': faqs?.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class FaqCategory {
  final String? categoryLabel;
  final List<FaqItem>? questions;

  FaqCategory({
    this.categoryLabel,
    this.questions,
  });

  factory FaqCategory.fromJson(Map<String, dynamic> json) {
    return FaqCategory(
      categoryLabel: json['categoryLabel'],
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => FaqItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryLabel': categoryLabel,
      'questions': questions?.map((e) => e.toJson()).toList(),
    };
  }
}

class FaqItem {
  final String? question;
  final String? answer;

  FaqItem({this.question, this.answer});

  factory FaqItem.fromJson(Map<String, dynamic> json) {
    return FaqItem(
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}
