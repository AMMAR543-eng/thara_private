import '../../../../../../index/index_main.dart';

class DigitalSignatureAgreementWidget extends StatelessWidget {
  final VoidCallback? onPreview;

  const DigitalSignatureAgreementWidget({super.key, this.onPreview});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: const DecorationImage(
          image: AssetImage(Images.background_light),
          fit: BoxFit.fill,
        ),
      ),
      child: InkWell(
        onTap: () {
          onPreview!();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              IconsConstants.pdf_file_icom, // 👈 replace with your file icon
              height: 28.h,
              width: 28.w,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "register_info_signature_title".tr,
                style: context.typography.headerLarge.copyWith(
                  color: AppColors.brand_bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),

            /// Top row: Title + File Icon
            SizedBox(height: 16.h),

            /// Preview Button Row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "view".tr,
                  style: context.typography.bodyMedium.copyWith(
                    color: AppColors.action_natural_normal,
                  ),
                ),
                SizedBox(width: 8.w),

                SvgPicture.asset(
                  IconsConstants.eye_icon, // 👈 your "eye" icon
                  height: 20.h,
                  width: 20.w,
                  color: AppColors.textDefault,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
