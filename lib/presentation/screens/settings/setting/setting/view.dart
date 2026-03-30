
import 'package:thara/index/index_main.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      init: SettingController(),
      builder: (controller) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: LocalStorageTheme().read() == "light"
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: Scaffold(
            backgroundColor: AppColors.background_neutral_surface,
            appBar: TitleWithBackAppbar(title: "profile_title".tr),
            body: Stack(
              children: [
                /// 🔹 Background pattern
                Positioned(
                  left: -150,
                  top: 20,
                  child: Image.asset(
                    Images.home_pattern,
                    width: ScreenUtil().screenWidth,
                    height: 500.h,
                    fit: BoxFit.fill,
                    color: AppColors.focus_input_text.withValues(alpha: 0.04),
                  ),
                ),

                /// 🔹 Main content
                SafeArea(child: _buildProfileContent(context, controller)),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 🖼️ Helper: profile image logic
  CachedNetworkImage _getProfileImage(SettingController controller) {
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

  Widget _buildProfileContent(
    BuildContext context,
    SettingController controller,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                              color: AppColors.grayLight, // optional background
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              // 👈 THIS is key
                              child: _getProfileImage(controller),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: controller.changeProfilePhoto,
                              child: Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: BoxDecoration(
                                  color: AppColors.action_primary_normal,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: AppColors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                          if ((controller
                                      .profileData
                                      ?.account
                                      ?.profilePhoto
                                      ?.url ??
                                  "")
                              .isNotEmpty)
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: GestureDetector(
                                onTap: controller.deleteProfilePhoto,
                                child: Container(
                                  padding: EdgeInsets.all(6.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12.withValues(
                                          alpha: 0.08,
                                        ),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: AppColors.errorForeground,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        controller.userInfoModel?.personalInfo?.fullNameAr ??
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

          /// --- Shortcuts
          LoginResponseModel().getTokenData()?.data?.accessToken == null
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.only(top: 15.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ShortcutButton(
                          label: "account_settings".tr,
                          icon: IconsConstants.setting_icon,
                          onTap: controller.goToAccountSettings,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: ShortcutButton(
                          label: "personal_info".tr,
                          icon: IconsConstants.profile_icon,
                          onTap: controller.goToPersonalInfo,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: GetBuilder<AppLanguage>(
                          init: AppLanguage(),
                          builder: (controller_lang) {
                            return ShortcutButton(
                              label: LocalStorage_language().read() == "ar"
                                  ? "language_option".tr
                                  : "arabic".tr,
                              icon: IconsConstants.language_icon,
                              onTap: () {
                                controller.showLanguageBottomSheet(
                                  context,
                                  controller_lang,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

          LoginResponseModel().getTokenData()?.data?.accessToken == null
              ? const SizedBox()
              : SizedBox(height: 24.h),

          /// --- الحساب والإعدادات Section
          LoginResponseModel().getTokenData()?.data?.accessToken == null
              ? const SizedBox()
              : _buildSectionTitle(context, "account_and_settings".tr),
          LoginResponseModel().getTokenData()?.data?.accessToken == null
              ? const SizedBox()
              : _buildCardContainer([
                  _buildListItem(
                    context,
                    "change_password".tr,
                    IconsConstants.change_pass,
                    onTap: controller.changePassword,
                  ),
                  _buildListItem(
                    context,
                    "manage_notifications".tr,
                    IconsConstants.notification_icon,
                    onTap: controller.manageNotifications,
                  ),
                  _buildFaceIDToggle(context, controller),
                ]),

          LoginResponseModel().getTokenData()?.data?.accessToken == null
              ? const SizedBox()
              : SizedBox(height: 20.h),

          /// --- المساعدة والدعم Section
          LoginResponseModel().getTokenData()?.data?.accessToken == null
              ? const SizedBox()
              : _buildSectionTitle(context, "help_and_support".tr),
          LoginResponseModel().getTokenData()?.data?.accessToken == null
              ? const SizedBox()
              : _buildCardContainer([
                  _buildListItem(
                    context,
                    "raise_ticket".tr,
                    IconsConstants.ticket,
                    onTap: controller.openTicket,
                  ),
                  _buildListItem(
                    context,
                    "8001240393",
                    IconsConstants.call_icon,
                    trailing: _buildActionText(context, "call".tr),
                    onTap: () async {
                      final Uri phoneUri = Uri(
                        scheme: 'tel',
                        path: '8001240393',
                      );
                      if (await canLaunchUrl(phoneUri)) {
                        await launchUrl(phoneUri);
                      } else {
                        Loader.showError("call_failed".tr);
                      }
                    },
                  ),
                  _buildListItem(
                    context,
                    "care@tharaco.sa",
                    IconsConstants.email,
                    trailing: _buildActionText(context, "message".tr),
                    onTap: () async {
                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: 'care@tharaco.sa',
                        query: Uri.encodeFull(
                          'subject=Support&body=Hello Thara Team,',
                        ),
                      );
                      if (await canLaunchUrl(emailUri)) {
                        await launchUrl(emailUri);
                      } else {
                        Loader.showError("email_failed".tr);
                      }
                    },
                  ),
                  _buildListItem(
                    context,
                    "info@tharaco.sa",
                    IconsConstants.info_icon,
                    trailing: _buildActionText(context, "message".tr),
                    onTap: () async {
                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: 'info@tharaco.sa',
                        query: Uri.encodeFull(
                          'subject=General Inquiry&body=Hello, I have a question.',
                        ),
                      );
                      if (await canLaunchUrl(emailUri)) {
                        await launchUrl(emailUri);
                      } else {
                        Loader.showError("email_failed".tr);
                      }
                    },
                  ),
                  _buildListItem(
                    context,
                    "faq".tr,
                    IconsConstants.faq_icon,
                    onTap: controller.showFAQ,
                    islast: true,
                  ),
                ]),

          LoginResponseModel().getTokenData()?.data?.accessToken == null
              ? const SizedBox()
              : SizedBox(height: 20.h),

          /// --- أخرى Section
          LoginResponseModel().getTokenData()?.data?.accessToken == null
              ? const SizedBox()
              : _buildSectionTitle(context, "others".tr),
          _buildCardContainer([
            GetBuilder<AppLanguage>(
              init: AppLanguage(),
              builder: (controller_lang) {
                return _buildListItem(
                  context,
                  "language_option".tr,
                  IconsConstants.language_icon,
                  onTap: () {
                    controller.showLanguageBottomSheet(
                      context,
                      controller_lang,
                    );
                  },
                );
              },
            ),

            GetBuilder<AppThemeController>(
              init: AppThemeController(),
              builder: (controller) {
                return SettingsItemWidget(
                  title: "theme".tr,
                  icon: IconsConstants.theme,
                  onTap: () {
                    showThemeBottomSheet(context);
                  },
                );
              },
            ),
            const Divider(height: 1, color: AppColors.border_natural_normal),

            _buildListItem(
              context,
              "about_thara".tr,
              IconsConstants.logo_setting,
              onTap: controller.aboutThara,
            ),
            _buildListItem(
              context,
              "islamic_compliance".tr,
              IconsConstants.islamic,
              onTap: controller.showCompliance,
            ),
            _buildListItem(
              context,
              "financial_reports_title".tr,
              IconsConstants.terms,
              onTap: controller.financial_report,
            ),
            _buildListItem(
              context,
              "credit_rating".tr,
              IconsConstants.terms,
              onTap: controller.creditRating,
            ),
            _buildListItem(
              context,
              "terms_conditions".tr,
              IconsConstants.termmms,
              onTap: controller.terms,
            ),
            _buildListItem(
              context,
              "articles".tr,
              IconsConstants.articles,
              onTap: controller.articles,
            ),
            _buildListItem(
              context,
              "indicator".tr,
              IconsConstants.articles,
              onTap: controller.indicators,
            ),
            _buildListItem(
              context,
              "visit_website".tr,
              IconsConstants.website_icon,
              onTap: controller.openWebsite,
              islast: true,
            ),
          ]),

          SizedBox(height: 32.h),

          /// --- Footer
          Column(
            children: [
              SvgPicture.asset(
                IconsConstants.logo_setting,
                width: 200.w,
                height: 40.h,
                color: AppColors.primary,
              ),
              SizedBox(height: 8.h),
              Text(
                "license_note".tr,
                style: context.typography.bodySmall.copyWith(
                  color: AppColors.content_primary,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "about_paragraph".tr,
                  style: context.typography.bodySmall.copyWith(
                    color: AppColors.content_secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "app_version".tr,
                style: context.typography.bodySmall.copyWith(
                  color: AppColors.content_secondary,
                ),
              ),
              SizedBox(height: 10.h),
              LoginResponseModel().getTokenData()?.data?.accessToken == null
                  ? SizedBox(
                      width: ScreenUtil().screenWidth,
                      child: PrimaryTextButton(
                        label: Text(
                          "login".tr,
                          style: context.typography.bodyLarge.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        onTap: () {
                          Get.offAllNamed(loginScreen);
                        },
                        customBackgroundColor: AppColors.action_primary_normal,
                      ),
                    )
                  : SizedBox(
                      width: ScreenUtil().screenWidth,
                      child: PrimaryTextButton(
                        label: Text(
                          "logout".tr,
                          style: context.typography.bodyLarge.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        onTap: controller.logout,
                        customBackgroundColor: AppColors.action_primary_normal,
                      ),
                    ),
              SizedBox(height: 24.h),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionText(BuildContext context, String text) => Text(
    text,
    style: context.typography.bodyLarge.copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
    ),
  );

  Widget _buildSectionTitle(BuildContext context, String title) => Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Align(
      alignment: LocalStorage_language().read() == "en"
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Text(
        title,
        style: context.typography.bodyStrongMedium.copyWith(
          color: AppColors.content_secondary,
        ),
      ),
    ),
  );

  Widget _buildCardContainer(List<Widget> children) => Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 4.h),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black12.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(children: children),
  );

  Widget _buildListItem(
    BuildContext context,
    String title,
    String icon, {
    Widget? trailing,
    VoidCallback? onTap,
    bool? islast,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          leading: SvgPicture.asset(
            icon,
            width: 23.w,
            height: 23.h,
            color: Theme.of(Get.context!).brightness == Brightness.dark
                ? Colors.white
                : AppColors.primary,
          ),
          title: Text(
            title,
            style: context.typography.bodyMedium.copyWith(
              color: AppColors.content_brand_secondary,
            ),
          ),
          trailing: SizedBox(
            width: 90.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                trailing ?? const SizedBox(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(Get.context!).brightness == Brightness.dark
                      ? Colors.white
                      : AppColors.primary,
                ),
              ],
            ),
          ),
          onTap: onTap,
        ),
        islast == null
            ? const Divider(height: 1, color: AppColors.border_natural_normal)
            : const SizedBox(),
      ],
    );
  }

  Widget _buildFaceIDToggle(
    BuildContext context,
    SettingController controller,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            IconsConstants.biometric,
            width: 23.w,
            height: 23.h,
            color: Theme.of(Get.context!).brightness == Brightness.dark
                ? Colors.white
                : AppColors.primary,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              "face_id_login".tr,
              style: context.typography.bodyMedium.copyWith(
                color: AppColors.content_brand_secondary,
              ),
            ),
          ),
          Switch(
            value: controller.faceIDEnabled,
            onChanged: controller.toggleFaceID,
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
