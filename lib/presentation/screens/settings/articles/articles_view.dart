import '../../../../index/index_main.dart';
import 'articles_details_view.dart';

class ArticlesView extends StatelessWidget {
  const ArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const InnerViewAppBar(title: "مقالاتنا"),
      body: SafeArea(
        child: GetBuilder<ArticlesViewModel>(
          init: ArticlesViewModel(),
          builder: (controller) {
            final articles = controller.list_articles;

            if (articles == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (articles.isEmpty) {
              return Center(
                child: Text(
                  "لا توجد مقالات متاحة حالياً",
                  style: typography.bodyLarge.copyWith(
                    color: AppColors.tertiary,
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
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
                          "تصفح أحدث المقالات والموضوعات التي تهم المستثمرين والمقترضين في ذُرى.",
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

                  /// --- Articles List
                  ...articles.map(
                    (article) => _ArticleCard(
                      article: article,
                      controller: controller,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final ArticleItemModel article;
  final ArticlesViewModel controller;

  const _ArticleCard({
    required this.article,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final hasImage = article.image?.isNotEmpty == true;

    return GestureDetector(
      onTap: () {
        Get.to(
          () => ArticlesDetailsView(
            controller: controller,
            key_article: article.id ?? "",
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: AppColors.border_natural_normal,
            width: 0.8,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Image
            SizedBox(
              height: 180.h,
              width: double.infinity,
              child: hasImage
                  ? FadeInImage(
                      placeholder: const AssetImage(Images.placeholder),
                      image: NetworkImage(article.image ?? ""),
                      fit: BoxFit.cover,
                      imageErrorBuilder: (_, __, ___) => Image.asset(
                        Images.placeholder,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      Images.placeholder,
                      fit: BoxFit.cover,
                    ),
            ),

            /// --- Title & Meta
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? "",
                    style: typography.bodyStrongLarge.copyWith(
                      color: AppColors.content_primary,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    article.content ?? "",
                    style: typography.bodyMedium.copyWith(
                      color: AppColors.content_secondary,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16.h),

                  /// --- Read More
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "اقرأ المزيد",
                        style: typography.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.primary,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
