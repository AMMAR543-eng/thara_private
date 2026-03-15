import 'package:thara/Presentation/design_systems/widgets/check_box/selectable_card_check_box_widget.dart';
import 'package:thara/Presentation/design_systems/widgets/check_box/selectable_widget_with_check_box_.dart';
import 'package:thara/index/index_main.dart';

class BuildBoolWidget extends StatelessWidget {
  final KycItemEntity question;
  final KYCController kycController;

  const BuildBoolWidget({
    required this.question,
    required this.kycController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final groupValue = _getGroupValue();

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Yes / No options using SelectableWidgetWithCheckBox
          SelectableWidgetWithCheckBox(
            title: question.question ?? "",
            // no need for title here (we already show question above)
            options: [
              SelectableCardCheckBoxWidget(
                title: "نعم",
                isSelected: groupValue == "1",
                onTap: () => _handleSelection("1"),
              ),
              SelectableCardCheckBoxWidget(
                title: "لا",
                isSelected: groupValue == "0",
                onTap: () => _handleSelection("0"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// --- Helpers
  String? _getGroupValue() {
    final index = kycController.questionsAnswers?.indexWhere(
      (e) => e.id == question.id,
    );
    return index != null && index >= 0
        ? kycController.questionsAnswers![index].boolAnswer
        : null;
  }

  void _handleSelection(String? val) {
    if (val == null) return;
    final index = kycController.questionsAnswers?.indexWhere(
      (e) => e.id == question.id,
    );
    if (index == null || index == -1) {
      kycController.questionsAnswers?.add(
        KycItemEntity(
          id: question.id,
          category: question.category,
          type: question.type,
          boolAnswer: val,
        ),
      );
    } else {
      kycController.questionsAnswers?[index] = KycItemEntity(
        id: question.id,
        category: question.category,
        type: question.type,
        boolAnswer: val,
      );
    }
    kycController.update();
  }
}
