import 'package:thara/Presentation/screens/settings/faq/faqViewModel.dart';
import '../../../../index/index_main.dart';

class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:  InnerViewAppBar(title: "faq".tr),
      body: SafeArea(
        child: GetBuilder<FaqVieWModel>(
          init: FaqVieWModel(),
          builder: (controller) {
            final orderedCategories = controller.orderedCategories;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// --- Header
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          IconsConstants.logo,
                          height: 70.h,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "browse_faq".tr,
                          style: typography.bodyMedium.copyWith(
                            color: AppColors.content_secondary,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),

                  /// --- FAQ Categories
                  ...orderedCategories.map((category) {
                    final label = category.categoryLabel ?? "عام";
                    final questions = category.questions ?? [];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: typography.headerMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          ...questions.map(
                            (item) => _buildExpandableTile(context, item),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// --- FAQ Expansion Tile Card
  Widget _buildExpandableTile(BuildContext context, FaqItem item) {
    final typography = context.typography;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: AppColors.border_natural_normal,
            width: 0.7,
          ),
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          childrenPadding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: 12.h,
          ),
          trailing: const Icon(
            Icons.expand_more_rounded,
            color: AppColors.tertiary,
          ),
          title: Text(
            item.question ?? '',
            style: typography.bodyLarge.copyWith(
              color: AppColors.content_primary,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                item.answer ?? '',
                style: typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
