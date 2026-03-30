import 'package:thara/index/index_main.dart';

class BuildTextWidget extends StatelessWidget {
  final KycItemEntity question;
  final KYCController kycController;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  const BuildTextWidget({
    required this.question,
    required this.kycController,
    this.focusNode,
    required this.keyboardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final index = kycController.questionsAnswers?.indexWhere(
      (item) => item.id == question.id,
    );

    // If questionsAnswers is null → index = null
    // If not found → index = -1
    final existingAnswer = (index != null && index != -1)
        ? kycController.questionsAnswers![index]
        : null;

    final controller = TextEditingController(
      text: existingAnswer?.textAnswer ?? existingAnswer?.numberAnswer ?? "",
    );

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextInputWidget(
        title: question.question ?? "",
        appTextField: AppTextField(
          controller: controller,
          hintText: question.question ?? "",
          keyboardType: keyboardType,
          focusNode: focusNode,

          // ✅ Validation (you can customize based on type)
          validator: InputValidators.combine([
            notEmptyValidator,
            if (keyboardType == TextInputType.emailAddress)
              InputValidators.validateEmail,
          ]),

          onChanged: (value) {
            final isText =
                keyboardType == TextInputType.text ||
                keyboardType == TextInputType.emailAddress ||
                keyboardType == TextInputType.name;

            final newEntity = KycItemEntity(
              id: question.id,
              category: question.category,
              type: question.type,
              textAnswer: isText ? value : null,
              numberAnswer: !isText ? value : null,
            );

            if (index != null && index >= 0) {
              kycController.questionsAnswers?[index] = newEntity;
            } else {
              kycController.questionsAnswers?.add(newEntity);
            }

            kycController.update();
          },

          onValidationChanged: (isValid) {
            // Optional debug
            debugPrint("Validation changed for ${question.id}: $isValid");
          },
        ),
      ),
    );
  }
}
