import 'package:dotted_border/dotted_border.dart';
import 'package:thara/index/index_main.dart';

enum FileUploadStatus { initial, uploading, success, error }

class FileUploadWidget extends StatelessWidget {
  final String? fileName;
  final double? fileSize; // in MB
  final FileUploadStatus status;
  final double progress; // 0–1 for uploading
  final String? errorMessage;

  final VoidCallback onPickFile;
  final VoidCallback? onRemoveFile;
  final VoidCallback? onRetry;
  final VoidCallback? onReplace;

  const FileUploadWidget({
    super.key,
    this.fileName,
    this.fileSize,
    this.errorMessage,
    required this.status,
    required this.onPickFile,
    this.onRemoveFile,
    this.onRetry,
    this.onReplace,
    this.progress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case FileUploadStatus.initial:
        return InkWell(onTap: onPickFile, child: dottedUploadBox(context));

      case FileUploadStatus.uploading:
        final remainingSeconds =
            ((1 - progress) * 15).clamp(1, 60).toInt(); // fake calc (1–60s)

        return _buildUploadFileRow(
          context,
          background: AppColors.background_neutral_default,
          statusText:
              "${(progress * 100).toStringAsFixed(0)}% • متبقي $remainingSeconds ثانية",
          progressWidget: LinearProgressIndicator(
            value: progress,
            color: AppColors.primary,
            backgroundColor: AppColors.borderNeutralPrimary,
            minHeight: 4,
            borderRadius: BorderRadius.circular(4),
          ),
        );

      case FileUploadStatus.success:
        return _buildFileRow(
          context,
          background: AppColors.interaction_Default_SubtleNormal,
          // like screenshot
          trailing: InkWell(
            onTap: onReplace,
            child: Text(
              "استبدال",
              style: context.typography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );

      case FileUploadStatus.error:
        return _buildFileRow(
          context,
          background: AppColors.errorBackground,
          trailing: InkWell(
            onTap: onRetry,
            child: Text(
              "إعادة المحاولة",
              style: context.typography.bodyMedium.copyWith(
                color: AppColors.errorForeground,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          errorMessage: errorMessage,
        );
    }
  }

  Widget _buildFileRow(
    BuildContext context, {
    required Color background,
    Widget? trailing,
    String? errorMessage,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                _buildFileTypeIcon(),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName ?? "ملف غير معروف",
                        overflow: TextOverflow.ellipsis,
                        style: context.typography.bodyMedium.copyWith(
                          color: AppColors.content_primary,
                        ),
                      ),
                      if (fileSize != null)
                        Text(
                          "${fileSize!.toStringAsFixed(1)}MB",
                          style: context.typography.bodySmall.copyWith(
                            color: AppColors.content_secondary,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          if (trailing != null) ...[
            const SizedBox(height: 8),
            Align(alignment: Alignment.centerLeft, child: trailing),
          ],
          if (errorMessage != null) ...[
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const Icon(
                    Icons.error,
                    color: AppColors.errorForeground,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      errorMessage,
                      style: context.typography.bodySmall.copyWith(
                        color: AppColors.errorForeground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(width: 10),
          InkWell(
            onTap: onRemoveFile,
            child: Icon(
              Icons.close,
              size: 20,
              color: AppColors.content_primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadFileRow(
    BuildContext context, {
    required Color background,
    Widget? progressWidget,
    String? statusText,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              /// Remove button
              InkWell(
                onTap: onRemoveFile,
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: AppColors.content_primary,
                ),
              ),
              const SizedBox(width: 8),

              /// File name + size + status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileName ?? "ملف غير معروف",
                      overflow: TextOverflow.ellipsis,
                      style: context.typography.bodyMedium.copyWith(
                        color: AppColors.content_primary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (fileSize != null)
                      Text(
                        "${fileSize!.toStringAsFixed(1)}MB"
                        "${statusText != null ? " • $statusText" : ""}",
                        style: context.typography.bodySmall.copyWith(
                          color: AppColors.content_secondary,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              /// File type icon (e.g. PDF)
              _buildFileTypeIcon(),
            ],
          ),

          /// Progress bar
          if (progressWidget != null) ...[
            const SizedBox(height: 8),
            progressWidget,
          ],
        ],
      ),
    );
  }

  Widget _buildFileTypeIcon() {
    if (fileName?.toLowerCase().endsWith(".pdf") == true) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.errorForeground),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          "PDF",
          style: Get.context!.typography.bodySmall.copyWith(
            color: AppColors.errorForeground,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return SvgPicture.asset(IconsConstants.pdf_icon);
  }
}

Widget dottedUploadBox(BuildContext context) {
  return DottedBorder(
    color: AppColors.borderNeutralPrimary,
    strokeWidth: 1,
    borderType: BorderType.RRect,
    radius: const Radius.circular(12),
    dashPattern: const [6, 4],
    // 6px line, 4px gap
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(IconsConstants.upload),
          const SizedBox(height: 12),
          Text(
            "يرجى إرفاق الإثبات",
            style: context.typography.bodyMedium.copyWith(
              color: AppColors.content_primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "بصيغة jpg أو png أو doc أو xls أو pdf بحد أقصى 5 MB للملفات",
            style: context.typography.bodySmall.copyWith(
              color: AppColors.content_secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
