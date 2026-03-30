import '../../../../index/index_main.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: InnerViewAppBar(title: "terms_conditions".tr),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- Header Section
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      IconsConstants.logo,
                      height: 70.h,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "terms_intro_text".tr,
                      textAlign: TextAlign.center,
                      style: typography.bodyMedium.copyWith(
                        color: AppColors.content_secondary,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),

              /// --- Terms Sections (Dynamic)
              _section(context, "terms_intro_title".tr,
                  _paragraphList(context, "terms_intro_list")),
              _section(context, "terms_eligibility_title".tr,
                  _paragraphList(context, "terms_eligibility_list")),
              _section(context, "terms_illegal_title".tr,
                  _bulletList(context, "terms_illegal_list")),
              _section(context, "terms_prohibited_title".tr,
                  _bulletList(context, "terms_prohibited_list")),
              _section(context, "terms_fees_title".tr,
                  _paragraphList(context, "terms_fees_list")),
              _section(context, "terms_warranty_title".tr,
                  _paragraphList(context, "terms_warranty_list")),
              _section(context, "terms_liability_title".tr,
                  _bulletList(context, "terms_liability_list")),
              _section(context, "terms_conflict_title".tr,
                  _paragraphList(context, "terms_conflict_policy_list")),
              _section(context, "terms_dispute_title".tr,
                  _paragraphList(context, "terms_dispute_list")),
              _section(context, "terms_general_title".tr,
                  _bulletList(context, "terms_general_list")),
              _section(context, "terms_obligations_title".tr,
                  _bulletList(context, "terms_obligations_list")),
              SizedBox(height: 40.h),

              /// --- Footer
              Center(
                child: Text(
                  "terms_footer_text".tr,
                  style: typography.bodySmall.copyWith(
                    color: AppColors.tertiary,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --- Section Builder
  Widget _section(BuildContext context, String title, List<Widget> children) {
    final typography = context.typography;
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: typography.headerMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
          ...children,
        ],
      ),
    );
  }

  /// --- Paragraph List Builder
  List<Widget> _paragraphList(BuildContext context, String baseKey) {
    final List<Widget> widgets = [];
    int index = 1;
    while ('$baseKey$index'.tr != '$baseKey$index') {
      widgets.add(_paragraph(context, '$baseKey$index'.tr));
      index++;
    }
    return widgets;
  }

  /// --- Bullet List Builder
  List<Widget> _bulletList(BuildContext context, String baseKey) {
    final List<Widget> widgets = [];
    int index = 1;
    while ('$baseKey$index'.tr != '$baseKey$index') {
      widgets.add(_bullet(context, '$baseKey$index'.tr));
      index++;
    }
    return widgets;
  }

  /// --- Paragraph Widget
  Widget _paragraph(BuildContext context, String text) {
    final typography = context.typography;
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: typography.bodyMedium.copyWith(
          color: AppColors.content_secondary,
          height: 1.6,
        ),
      ),
    );
  }

  /// --- Bullet Widget
  Widget _bullet(BuildContext context, String text) {
    final typography = context.typography;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "•",
            style: typography.headerMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: typography.bodyMedium.copyWith(
                color: AppColors.content_secondary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
