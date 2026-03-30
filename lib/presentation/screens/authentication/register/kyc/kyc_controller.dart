import '../../../../../index/index_main.dart';

class KYCController extends GetxController {
  KycQuestionsEntity? kycQuestion;
  List<KycItemEntity>? questionsAnswers = [];
  bool? is_loading;

  bool containsQuestionId(int id) {
    return questionsAnswers?.any((item) => item.id == id) ?? false;
  }

  bool containsQuestionAnswerId(int id, int index) {
    return questionsAnswers?[index].answers?.any((item) => item?.id == id) ??
        false;
  }

  bool hasFileAnswers() {
    return questionsAnswers?.any((item) => item.file?.isNotEmpty == true) ??
        false;
  }

  bool areAllQuestionsAnswered() {
    if (kycQuestion?.questions == null) return false;
    final totalQuestions = kycQuestion!.questions!;
    final answers = questionsAnswers ?? [];

    for (final question in totalQuestions) {
      final match = answers.firstWhere(
        (e) => e.id == question.id,
        orElse: () => const KycItemEntity(),
      );

      switch (question.type) {
        case 'text':
          if (match.textAnswer?.trim().isEmpty ?? true) return false;
          break;
        case 'number':
          if (match.numberAnswer?.trim().isEmpty ?? true) return false;
          break;
        case 'bool':
          if (match.boolAnswer == null) return false;
          break;
        case 'file':
          if (match.file?.isEmpty ?? true) return false;
          break;
        case 'single_choice':
          if (match.answers == null || match.answers!.isEmpty) return false;
          break;
        case 'multi_choice':
          if (match.answers == null || match.answers!.isEmpty) return false;
          break;
        default:
          return false;
      }
    }

    return true;
  }

  @override
  void onInit() {
    getKYCQuestionsApi();
    super.onInit();
  }

  getKYCQuestionsApi() {
    RegisterService().getKYCQuestions(
      voidCallBack: (data) {
        kycQuestion = data;
        update();
      },
    );
  }

  sendKYCQuestionAnswerApi() {
    is_loading = true;

    if (hasFileAnswers()) {
      // Send with multipart

      RegisterService().sendKYCQuestionAnswerWithFiles(
        questions: questionsAnswers,
        voidCallBack: (data) {
          if (data.customStatusCode == 200) {
            if (data.account?.type == "company") {
              Get.offAndToNamed(successAuthView);
            } else {
              Get.offAll(
                () => const RegisterParentView(index: 3),
                binding: Binding(),
              );
            }
          }
          is_loading = false;
          update();
        },
      );
    } else {
      // Send normally without files
      RegisterService().sendKYCQuestionAnswer(
        questions: questionsAnswers,
        voidCallBack: (data) {
          if (data.customStatusCode == 200) {
            Get.offAll(
              () => const RegisterParentView(index: 3),
              binding: Binding(),
            );
          }
          is_loading = false;
          update();
        },
      );
    }
  }
}
