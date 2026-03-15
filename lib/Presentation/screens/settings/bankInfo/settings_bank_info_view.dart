import 'package:thara/index/index_main.dart';
import '../widgets/shimmer_info_item_widget.dart';

class SettingsBankInfoView extends StatelessWidget {
  const SettingsBankInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          "bank_info".tr,
          textAlign: TextAlign.center,
          style: context.typography.font55GreyLeft.copyWith(
            color: AppColors.background_black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: GetBuilder<SettingsBasicInfoController>(
        init: SettingsBasicInfoController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
            child: controller.profileData == null
                ? const InfoListShimmerWidget()
                : SingleChildScrollView(
              child: Column(
                children: [
                  InfoItemWidget(
                    label: 'beneficiary_name'.tr,
                    value: controller.profileData?.account?.ownerName ?? "",
                    typography: typography,
                    showEdit: false,
                  ),
                  SizedBox(height: 10.h),
                  Divider(
                    color: AppColors.grayMedium.withAlpha(30),
                    endIndent: 20.h,
                    indent: 20.h,
                  ),
                  SizedBox(height: 10.h),
                  InfoItemWidget(
                    label: 'iban_number'.tr,
                    value: controller.profileData?.account?.virtualAccount?.iban ?? "",
                    typography: typography,
                    showEdit: false,
                  ),
                  SizedBox(height: 10.h),
                  Divider(
                    color: AppColors.grayMedium.withAlpha(30),
                    endIndent: 20.h,
                    indent: 20.h,
                  ),
                  SizedBox(height: 10.h),
                  InfoItemWidget(
                    label: 'account_number'.tr,
                    value: controller.profileData?.account?.virtualAccount?.accountNumber ?? "",
                    typography: typography,
                    showEdit: false,
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
