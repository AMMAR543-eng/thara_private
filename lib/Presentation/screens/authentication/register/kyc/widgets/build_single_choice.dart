import 'package:thara/index/index_main.dart';

class BuildSingleChoiceWidget extends StatelessWidget {
  final KycItemEntity question;
  final KYCController kycController;

  const BuildSingleChoiceWidget({
    required this.question,
    required this.kycController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Map question answers -> GenericListModel list
    final List<GenericListModel> listTypes = question.answers
        ?.map((element) {
      return GenericListModel(
        id: element?.id ?? 0,
        name_ar: element?.answer,
        name: element?.answer,
      );
    })
        .cast<GenericListModel>()
        .toList() ??
        [];

    // Check if an answer already exists in controller
    GenericListModel? selectedType;
    final existingIndex = kycController.questionsAnswers
        ?.indexWhere((item) => item.id == question.id);

    if (existingIndex != null && existingIndex >= 0) {
      final existingAnswer =
          kycController.questionsAnswers?[existingIndex].answers?.first;
      if (existingAnswer != null) {
        selectedType = listTypes.firstWhere(
              (element) => element.id == existingAnswer.id,
          orElse: () => GenericListModel(
            id: existingAnswer.id ?? 0,
            name: existingAnswer.answer ?? "",
            name_ar: existingAnswer.answer ?? "",
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: GenericNewDropdown<GenericListModel>(
        title: question.question ?? "",
        hint: question.question ?? "",
        items: listTypes,
        selectedItem: selectedType,
        itemLabel: (item) => item.name_ar ?? item.name ?? "",
        onChanged: (value) {
          if (value == null) return;

          if (!kycController.containsQuestionId(question.id!)) {
            // add new
            kycController.questionsAnswers?.add(
              KycItemEntity(
                id: question.id,
                category: question.category,
                type: question.type,
                answers: [
                  AnswersEntity(id: value.id, answer: value.name),
                ],
              ),
            );
          } else {
            // update existing
            final idx = kycController.questionsAnswers
                ?.indexWhere((item) => item.id == question.id);
            if (idx != null && idx >= 0) {
              kycController.questionsAnswers?[idx] = KycItemEntity(
                id: question.id,
                category: question.category,
                type: question.type,
                answers: [
                  AnswersEntity(id: value.id, answer: value.name),
                ],
              );
            }
          }

          kycController.update();
        },
      ),
    );
  }
}
