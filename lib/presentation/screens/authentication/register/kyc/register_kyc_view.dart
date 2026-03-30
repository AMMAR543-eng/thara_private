import 'package:thara/Presentation/screens/authentication/register/kyc/widgets/build_kyc_widget.dart';
import '../../../../../index/index_main.dart';

class RegisterKYCScreen extends StatefulWidget {
  const RegisterKYCScreen({super.key});

  @override
  State<RegisterKYCScreen> createState() => _RegisterKYCScreenState();
}

class _RegisterKYCScreenState extends State<RegisterKYCScreen> {
  late GenericKeyboardManager<String> keyboardManager;
  final formKycKey = GlobalKey<FormState>();

  @override
  void initState() {
    keyboardManager = GenericKeyboardManager<String>(nodeCount: 1);
    super.initState();
  }

  @override
  void dispose() {
    keyboardManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: GetBuilder<KYCController>(
        init: KYCController(),
        builder: (controller) {
          final isEnabled = controller.areAllQuestionsAnswered();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                width: ScreenUtil().screenWidth,
                child: PressAnimatedButton(
                  backgroundColor: AppColors.primary_normal,
                  borderRadius: BorderRadius.circular(10),
                  label: Text(
                    "التالي",
                    style: context.typography.bodyLarge.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  enabled: true,
                  // 🔹 you can bind this to controller state if needed
                  onTap: isEnabled
                      ? () {
                          controller.sendKYCQuestionAnswerApi();
                        }
                      : null,
                ),
              ),
            ),
          );
        },
      ),
      body: GetBuilder<KYCController>(
        init: KYCController(),
        builder: (controller) {
          return KeyboardActions(
            config: keyboardManager.buildConfig(),
            child: SingleChildScrollView(
              child: Form(
                key: formKycKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Section Title
                    Text(
                      "التفاصيل الإضافية",
                      style: context.typography.headerLarge.copyWith(
                        color: AppColors.content_brand_secondary,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    /// Dynamic KYC Questions
                    if (controller.kycQuestion?.questions != null)
                      ...controller.kycQuestion!.questions!.map(
                        (question) => BuildKYCWidget(
                          question: question,
                          kycController: controller,
                          manager: keyboardManager,
                        ),
                      ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
