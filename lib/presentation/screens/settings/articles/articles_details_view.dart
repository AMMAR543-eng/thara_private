import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../index/index_main.dart';

class ArticlesDetailsView extends StatefulWidget {
  final String key_article;
  final ArticlesViewModel controller;

  const ArticlesDetailsView({
    super.key,
    required this.key_article,
    required this.controller,
  });

  @override
  State<ArticlesDetailsView> createState() => _ArticlesDetailsViewState();
}

class _ArticlesDetailsViewState extends State<ArticlesDetailsView> {
  late ArticlesViewModel controller;

  @override
  void initState() {
    controller = initUseCase(() => ArticlesViewModel());
    controller.getArticle_details(widget.key_article);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const InnerViewAppBar(title: "تفاصيل المقال"),
      body: SafeArea(
        child: GetBuilder<ArticlesViewModel>(
          init: controller,
          builder: (_) {
            final article = controller.article_details;

            if (article == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// --- Header Image
                  if ((article.image?.isNotEmpty ?? false))
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: FadeInImage(
                        placeholder: const AssetImage(Images.placeholder),
                        image: NetworkImage(article.image ?? ""),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200.h,
                        imageErrorBuilder: (_, __, ___) => Image.asset(
                          Images.placeholder,
                          fit: BoxFit.cover,
                          height: 200.h,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  SizedBox(height: 20.h),

                  /// --- Title
                  Text(
                    article.title ?? "",
                    style: typography.headerLarge.copyWith(
                      color: AppColors.content_primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  /// --- Publish Date (if exists)
                  if (article.publishDate != null)
                    Text(
                      "نشر في ${article.publishDate}",
                      style: typography.bodyMedium.copyWith(
                        color: AppColors.tertiary,
                      ),
                    ),
                  SizedBox(height: 25.h),

                  /// --- HTML Content
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.background_neutral_surface,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: AppColors.border_natural_normal,
                        width: 0.6,
                      ),
                    ),
                    child: HtmlWidget(
                      article.content ?? '',
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.content_secondary,
                        fontFamily: Strings.fontname,
                        height: 1.8,
                      ),
                      customStylesBuilder: (element) {
                        switch (element.localName) {
                          case 'p':
                            return {
                              'margin-bottom': '8px',
                            };

                          case 'h2':
                            return {
                              'color':
                                  '#${AppColors.primary.value.toRadixString(16).substring(2)}',
                              'font-weight': 'bold',
                              'font-size': '${18.sp}px',
                              'margin-bottom': '8px',
                            };

                          case 'ul':
                            return {
                              'margin-left': '16px',
                              'margin-bottom': '8px',
                            };

                          case 'li':
                            return {
                              'color':
                                  '#${AppColors.content_primary.value.toRadixString(16).substring(2)}',
                              'font-size': '${13.sp}px',
                            };
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 40.h),

                  /// --- Back Button
                  Center(
                    child: PrimaryTextButton(
                      appButtonSize: AppButtonSize.large,
                      onTap: () => Get.back(),
                      label: Text(
                        "العودة إلى المقالات",
                        style: typography.bodyLarge.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
