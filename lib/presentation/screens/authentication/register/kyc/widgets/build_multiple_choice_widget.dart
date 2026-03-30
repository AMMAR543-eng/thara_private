import 'package:thara/index/index_main.dart';

class BuildMultipleChoiceWidget extends StatelessWidget {
  final KycItemEntity question;
  final KYCController kycController;

  const BuildMultipleChoiceWidget({
    required this.question,
    required this.kycController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final questionId = question.id;
    final answerList = question.answers;

    if (questionId == null || answerList == null || answerList.isEmpty) {
      return const SizedBox.shrink();
    }

    final questionsAnswers = kycController.questionsAnswers;
    final existingIndex = questionsAnswers?.indexWhere(
      (item) => item.id == questionId,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Question text
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              question.question ?? "",
              style: context.typography.bodyLarge.copyWith(
                color: AppColors.content_primary,
              ),
            ),
          ),

          /// --- Answers as custom checkboxes
          Column(
            children: answerList.map((item) {
              final itemId = item?.id;
              final itemAnswer = item?.answer ?? "";

              bool selectedType = false;
              if (questionsAnswers != null &&
                  questionsAnswers.isNotEmpty &&
                  existingIndex != null &&
                  existingIndex >= 0 &&
                  itemId != null) {
                final currentAnswers =
                    questionsAnswers[existingIndex].answers ?? [];
                selectedType = currentAnswers.any(
                  (value) => value?.id == itemId,
                );
              }

              return InkWell(
                onTap: () {
                  _handleSelection(
                    itemId,
                    itemAnswer,
                    selectedType,
                    question,
                    existingIndex,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: selectedType
                          ? AppColors.focus_input_text
                          : AppColors.borderNeutralPrimary,
                      width: 0.5,
                    ),
                    color: selectedType
                        ? AppColors.primary.withValues(alpha: 0.05)
                        : AppColors.white,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        selectedType
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: selectedType
                            ? AppColors.primary
                            : AppColors.content_secondary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          itemAnswer,
                          style: context.typography.bodyMedium.copyWith(
                            color: selectedType
                                ? AppColors.primary
                                : AppColors.content_primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _handleSelection(
    int? itemId,
    String itemAnswer,
    bool selectedType,
    KycItemEntity question,
    int? existingIndex,
  ) {
    if (itemId == null) return;

    final existingAnswerList = kycController.questionsAnswers;
    final questionId = question.id;

    if (questionId == null) return;

    if (!kycController.containsQuestionId(questionId) && !selectedType) {
      existingAnswerList?.add(
        KycItemEntity(
          id: questionId,
          category: question.category,
          type: question.type,
          answers: [AnswersEntity(id: itemId, answer: itemAnswer)] ,
        ),
      );
    } else if (existingIndex != null &&
        existingIndex >= 0 &&
        !kycController.containsQuestionAnswerId(itemId, existingIndex) &&
        !selectedType) {
      existingAnswerList?[existingIndex].answers?.add(
        AnswersEntity(id: itemId, answer: itemAnswer),
      );
    } else if (existingIndex != null && existingIndex >= 0) {
      final currentAnswers = existingAnswerList?[existingIndex].answers;
      if (currentAnswers?.length == 1) {
        existingAnswerList?.removeAt(existingIndex);
      } else {
        currentAnswers?.removeWhere((e) => e?.id == itemId);
      }
    }

    kycController.update();
  }
}
