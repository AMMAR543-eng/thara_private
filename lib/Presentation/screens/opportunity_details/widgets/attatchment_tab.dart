import 'package:thara/Global/Utils/pdf_viewer.dart';
import '../../../../index/index_main.dart';

class AttachmentsTab extends StatelessWidget {
  final List<AttachmentModel> attatches;

  const AttachmentsTab({super.key, required this.attatches});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(attatches.length, (index) {
        final item = attatches[index];
        final mime = item.media?.mime ?? "";
        final isPdf = mime.toLowerCase().contains("pdf");

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            //  color: AppColors.greyLight.withValues(alpha: 0.4),
            color: LocalStorageTheme().read() == "light"
                ? AppColors.greyLight.withValues(alpha: 0.4)
                : AppColors.content_secondary,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Attachment Title
              Text(
                item.title ?? "attachment".tr,
                style: context.typography.bodyLarge.copyWith(
                  color: AppColors.background_black,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 6.h),

              /// 🔹 Download Button
              if (isPdf)
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => GenericPdfViewer(
                        fileName: "thara_${item.media?.id}.pdf",
                        pdfUrl: item.media?.url ?? "",
                      ),
                      binding: Binding(),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "download".tr,
                        style: context.typography.bodyMedium.copyWith(
                          color: AppColors.primary_normal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.arrow_downward,
                        size: 18.sp,
                        color: AppColors.primary_normal,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
