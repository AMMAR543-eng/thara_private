import '../../../../index/index_main.dart';

class DashboardHeaderWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const DashboardHeaderWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final bool isAuthenticated =
        LoginResponseModel().getTokenData()?.data?.accessToken != null;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: GetBuilder<MainPageController>(
        init: MainPageController(),
        builder: (controller) {
          return SafeArea(
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      final token = LoginResponseModel()
                          .getTokenData()
                          ?.data
                          ?.accessToken;
                      if (token == null) {
                        CheckGuestUser().openGuestUserBottomSheet(
                          "login_first".tr,
                        );
                      } else {
                        Get.toNamed(settingsBasicInfoView);
                      }
                    },
                    child: CircleAvatar(
                      radius: 29,
                      backgroundColor: AppColors.moonstoneBlue,
                      child: CircleAvatar(
                        radius: 27,
                        backgroundColor: AppColors.white,
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(Images.image),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "welcome_back".tr,
                        style: context.typography.font33Grey.copyWith(
                          color: AppColors.background_black,
                          height: 1,
                        ),
                      ),
                      Text(
                        controller.name ?? "",
                        style: context.typography.font52Grey.copyWith(
                          color: AppColors.background_black,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Visibility(
                  //   visible: isAuthenticated,
                  //   child: InkWell(
                  //     onTap: () {
                  //       Get.to(
                  //             () => const NotificationView(),
                  //         duration: const Duration(milliseconds: 0),
                  //         binding: Binding(),
                  //       );
                  //     },
                  //     child: SvgPicture.asset(
                  //       IconsConstants.notification,
                  //       fit: BoxFit.contain,
                  //       height: 48.h,
                  //       width: 54.w,
                  //       color: AppColors.background_black,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
