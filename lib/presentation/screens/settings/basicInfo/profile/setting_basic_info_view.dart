import 'package:thara/index/index_main.dart';

class SettingsBasicInfoView extends StatelessWidget {
  const SettingsBasicInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: InnerViewAppBar(title: "personal_info".tr),
      body: GetBuilder<SettingsBasicInfoController>(
        init: SettingsBasicInfoController(),
        builder: (controller) {
          final user = controller.userInfoModel?.personalInfo;
          final company = controller.userInfoModel?.companyInfo ?? [];

          if (user == null) {
            return const Padding(
              padding: EdgeInsets.all(15.0),
              child: InfoListShimmerWidget(),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // /// --- Profile Header
                // ProfileHeaderSection(
                //   imageUrl: controller.account?.profilePhoto?.url,
                //   fullNameAr: user.fullNameAr ?? "",
                //   accountId:
                //       controller.profileData?.account?.id ?? "ACC-2025021967",
                // ),

                /// --- Profile Header
                LoginResponseModel().getTokenData()?.data?.accessToken == null
                    ? const SizedBox()
                    : Center(
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 130.w,
                                  height: 130.h,
                                  decoration: BoxDecoration(
                                    color: AppColors
                                        .grayLight, // optional background
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    // 👈 THIS is key
                                    child: _getProfileImage(controller),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              controller.userInfoModel?.personalInfo
                                      ?.fullNameAr ??
                                  "",
                              style: context.typography.headerXLarge.copyWith(
                                color: AppColors.content_primary,
                              ),
                            ),
                            Text(
                              controller.profileData?.account?.id ?? "",
                              style: context.typography.bodyMedium.copyWith(
                                color: AppColors.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InfoTextColumn(
                        title: "name_in_english".tr,
                        value: user.fullNameEn ?? "-",
                      ),
                    ),
                    SizedBox(
                      width: 120.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(IconsConstants.owner),
                          Text(
                            "account_owner".tr,
                            style: Get.context!.typography.bodyStrongLarge
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: InfoTextColumn(
                        title: "national_id_or_residence".tr,
                        value: controller.profileData?.user?.nin ?? "-",
                      ),
                    ),
                    SizedBox(
                      width: 120.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "birth_date_gregorian".tr,
                            textAlign: TextAlign.center,
                            style: Get.context!.typography.bodyMedium.copyWith(
                              color: AppColors.content_secondary,
                            ),
                          ),
                          Text(
                            user.dateOfBirthG ?? "-",
                            style: Get.context!.typography.bodyStrongLarge
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: InfoTextColumn(
                        title: "mobile_number".tr,
                        value: controller.profileData?.user?.phoneNumber ?? "-",
                      ),
                    ),
                    PrimaryTextButton(
                      onTap: () {
                        controller.startEmailChangeFlow(context);
                      },
                      customBackgroundColor: AppColors.white,
                      label: Text(
                        "edit".tr,
                        style: context.typography.bodyLarge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      appButtonSize: AppButtonSize.large,
                      leading: (value) {
                        return SvgPicture.asset(IconsConstants.edit_icon);
                      },
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: InfoTextColumn(
                        title: "email_address".tr,
                        value: controller.profileData?.user?.email ?? "-",
                      ),
                    ),
                    PrimaryTextButton(
                      onTap: () {
                        controller.startPhoneChangeFlow(context);
                      },
                      customBackgroundColor: AppColors.white,
                      label: Text(
                        "edit".tr,
                        style: context.typography.bodyLarge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      appButtonSize: AppButtonSize.large,
                      leading: (value) {
                        return SvgPicture.asset(IconsConstants.edit_icon);
                      },
                    ),
                  ],
                ),

                /// --- Company Info (Dynamic)
                if (company.isNotEmpty) ...[
                  for (var item in company)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: SingleInfoLine(
                        title: _translateCompanyKey(item.key ?? "").tr,
                        value: item.value ?? "-",
                      ),
                    ),
                ],

                /// --- Investment Limit Section
                Text(
                  "investment_limit".tr, // حد الاستثمار
                  style: context.typography.bodyStrongLarge.copyWith(
                    color: AppColors.tertiary,
                  ),
                ),

                SizedBox(height: 10.h),

                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 6.h,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
                    activeTrackColor: AppColors.primary,
                    inactiveTrackColor:
                        AppColors.border_natural_normal.withValues(alpha: .2),
                  ),
                  child: Slider(
                    value: controller.investmentProgress,
                    // between 0 and 1
                    activeColor: AppColors.primary,
                    onChanged: (_) {},
                    min: 0,
                    max: 1,
                  ),
                ),

                SizedBox(height: 5.h),

                Row(
                  children: [
                    /// Formatted investment usage text
                    Text(
                      controller.investmentUsageText, // "﷼ 50,000.00 / 20%"
                      style: context.typography.bodyStrongLarge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SvgPicture.asset(
                      IconsConstants.riyal,
                      width: 20,
                      height: 20,
                      color: AppColors.content_primary,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  CachedNetworkImage _getProfileImage(SettingsBasicInfoController controller) {
    final photoUrl = controller.profileData?.account?.profilePhoto?.url;

    if (photoUrl != null && photoUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: photoUrl,
        fit: BoxFit.cover,
        width: double.infinity.w,
        height: double.infinity.h,
      );
    }

    final altPhoto = controller.userInfoModel?.account?.profilePhoto?.url;
    if (altPhoto != null && altPhoto.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: altPhoto,
        fit: BoxFit.cover,
        width: double.infinity.w,
        height: double.infinity.h,
      );
    }

    return CachedNetworkImage(
      imageUrl: Strings.placeholder_image,
      fit: BoxFit.contain,
      width: double.infinity.w,
      height: double.infinity.h,
    );
  }

  /// 🔤 Translate company keys (localized)
  String _translateCompanyKey(String key) {
    switch (key) {
      case "name":
        return "company_name";
      case "field_of_business":
        return "company_field";
      case "crn":
        return "commercial_registration";
      case "unified_number":
        return "unified_number";
      default:
        return key;
    }
  }
}
