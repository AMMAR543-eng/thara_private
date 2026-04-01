import 'package:thara/Global/Utils/pdf_viewer.dart';
import '../../../../index/index_main.dart';

class FinanicalReportsView extends StatelessWidget {
  const FinanicalReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: InnerViewAppBar(title: "financial_reports_title".tr),
      body: SafeArea(
        child: GetBuilder<FinancialReportsVieWModel>(
          init: FinancialReportsVieWModel(),
          builder: (controller) {
            final reports = controller.finaniclaData?.financialStatements;

            if (reports == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (reports.isEmpty) {
              return Center(
                child: Text(
                  "no_financial_reports".tr,
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        SizedBox(height: 16.h),
                        Text(
                          "financial_reports_header".tr,
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

                  /// --- Financial Reports List
                  ...reports.map((report) => _buildReportCard(context, report)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// --- Report Card Widget
  Widget _buildReportCard(BuildContext context, FinancialStatementItem report) {
    final typography = context.typography;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: AppColors.border_natural_normal, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Year & Quarter Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${"financial_year".tr}${report.year ?? ""}",
                style: typography.bodyStrongLarge.copyWith(
                  color: AppColors.content_primary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  report.quarter ?? "—",
                  style: typography.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          /// --- Description
          Text(
            "financial_report_description".tr,
            style: typography.bodyMedium.copyWith(
              color: AppColors.content_secondary,
              height: 1.5,
            ),
          ),

          SizedBox(height: 16.h),

          /// --- Download Button Row
          GestureDetector(
            onTap: () {
              if (report.attachment?.isNotEmpty == true) {
                Get.to(
                  () => GenericPdfViewer(
                    fileName: "financial_report_${report.year}.pdf",
                    pdfUrl: report.attachment!,
                  ),
                  binding: Binding(),
                );
              } else {
                Loader.showError("no_file_available".tr);
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "download_report".tr,
                  style: typography.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                SvgPicture.asset(
                  IconsConstants.download,
                  width: 20.w,
                  height: 20.h,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
