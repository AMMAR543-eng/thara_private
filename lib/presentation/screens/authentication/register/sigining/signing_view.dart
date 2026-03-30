import 'package:thara/Global/Utils/pdf_viewer.dart';
import '../../../../../index/index_main.dart';

class RegisterSigningScreen extends StatefulWidget {
  const RegisterSigningScreen({super.key});

  @override
  State<RegisterSigningScreen> createState() => _RegisterSigningScreenState();
}

class _RegisterSigningScreenState extends State<RegisterSigningScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SigningController>(
      init: SigningController(),
      builder: (controller) {

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Title
            Text(
              "توقيع إتفاقية الإستثمار",
              style: context.typography.headerXLarge.copyWith(
                color: AppColors.content_brand_secondary,
              ),
            ),
            SizedBox(height: 16.h),

            /// --- Agreement Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.background_banner,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(IconsConstants.pdf_file_icom),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "إتفاقية الإستثمار",
                      style: context.typography.headerLarge.copyWith(
                        color: AppColors.brand_bold,
                      ),
                    ),
                  ),
                  Text(
                    "يرجى تحميل ملف الاتفاقية ومراجعة جميع بنودها، ثم الضغط على زر “توقيع” لتوقيع الاتفاقية وتفعيل حساب الاستثمار الخاص بك",
                    style: context.typography.bodyMedium.copyWith(
                      color: AppColors.tertiary,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => GenericPdfViewer(
                          fileName: "tharaSigning.pdf",
                          pdfUrl: controller.singing?.investAgreement ?? "",
                        ),
                        binding: Binding(),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "تحميل",
                          style: context.typography.bodyMedium.copyWith(
                            color: AppColors.primary_normal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SvgPicture.asset(
                            IconsConstants.download,
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// --- Buttons
            SizedBox(
              width: ScreenUtil().screenWidth,
              child: PressAnimatedButton(
                backgroundColor: AppColors.primary_normal,
                borderRadius: BorderRadius.circular(10),
                label: Text(
                  "توقيع",
                  style: context.typography.bodyLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),
                enabled: true,
                // 🔹 you can bind this to controller state if needed
                onTap: () => controller.singingWithSirar(),
              ),
            ),




            SizedBox(height: 12.h),
          ],
        );
      },
    );
  }
}
