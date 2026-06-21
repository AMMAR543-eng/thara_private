import '../../../../index/index_main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  List<OnboardingItem> get onboardingItems => [
        OnboardingItem(
          animation: Animations.onboard_1,
          title: "onboard_title_1".tr,
          description: "onboard_desc_1".tr,
        ),
        OnboardingItem(
          animation: Animations.onboard_2,
          title: "onboard_title_2".tr,
          description: "onboard_desc_2".tr,
        ),
        OnboardingItem(
          animation: Animations.onboard_3,
          title: "onboard_title_3".tr,
          description: "onboard_desc_3".tr,
        ),
      ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF002825),
        title: SvgPicture.asset(IconsConstants.logo),
        actions: [
          InkWell(
            onTap: () async {
              final controller = initUseCase(() => AppLanguage());
              final currentLang = LocalStorage_language().read();

              if (currentLang == 'ar') {
                controller.changeLanguage('en');
              } else {
                controller.changeLanguage('ar');
              }
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(Icons.language, color: AppColors.white, size: 25),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Container(
          decoration: const BoxDecoration(
            gradient: AppGradients.onboardingBackground,
          ),
          child: Stack(
            children: [
              /// PageView for animations
              PageView.builder(
                controller: _pageController,
                itemCount: onboardingItems.length,
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
                itemBuilder: (context, index) {
                  final item = onboardingItems[index];
                  return GenericAnimationWidget(
                    animation_file_name: item.animation,
                  );
                },
              ),

              /// 🔹 Bottom white card with text + indicator + buttons
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: ScreenUtil().screenHeight * 0.4,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 24.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A000000), // subtle shadow
                        blurRadius: 8,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Title
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          onboardingItems[currentPage].title,
                          style: context.typography.headerXLarge.copyWith(
                            color: AppColors.content_brand_secondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      /// Description
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 35),
                        child: Text(
                          onboardingItems[currentPage].description,
                          style: context.typography.bodyMedium.copyWith(
                            color: AppColors.content_secondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      /// Page indicator
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: onboardingItems.length,
                        effect: ExpandingDotsEffect(
                          expansionFactor: 3,
                          // how much the active dot expands
                          spacing: 8,
                          radius: 8,
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: AppColors.primary,
                          dotColor: AppColors.border_natural_normal,
                        ),
                      ),

                      const Spacer(),

                      /// Buttons
                      Row(
                        children: [
                          currentPage == 0
                              ? const SizedBox()
                              : Expanded(
                                  flex: 1,
                                  child: PrimaryTextButton(
                                    label: Text(
                                      "back".tr,
                                      style: context.typography.bodyLarge
                                          .copyWith(color: AppColors.primary),
                                    ),
                                    customBackgroundColor: AppColors.white,
                                    customBorder: const BorderSide(
                                      color: AppColors.border_natural_normal,
                                    ),
                                    onTap: () {
                                      if (currentPage > 0) {
                                        _pageController.previousPage(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    },
                                  ),
                                ),
                          SizedBox(width: 12.w),
                          Expanded(
                            flex: 3,
                            child: PrimaryTextButton(
                              label: Text(
                                currentPage == onboardingItems.length - 1
                                    ? "finish".tr
                                    : "next".tr,
                                style: context.typography.bodyLarge.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              onTap: () async {
                                if (currentPage == onboardingItems.length - 1) {
                                  await StorageService().setData(
                                    "firstLaunch",
                                    false,
                                  );
                                  Get.offAllNamed(loginScreen);
                                } else {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
