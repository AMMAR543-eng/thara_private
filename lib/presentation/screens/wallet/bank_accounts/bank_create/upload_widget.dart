import 'dart:io';
import '../../../../../index/index_main.dart';

class UploadProofBottomSheet extends StatelessWidget {
  final StoreBankController controller;

  const UploadProofBottomSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return GetBuilder<StoreBankController>(
      init: controller,
      builder: (_) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Handle bar
                Container(
                  width: 60.w,
                  height: 5.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: AppColors.border_default,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),

                /// 🔹 Title
                Text(
                  "attach_account_ownership_proof".tr,
                  style: typography.headerLarge.copyWith(
                    color: AppColors.content_primary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),

                /// 🔹 Description
                Text(
                  "upload_account_proof_description".tr,
                  style: typography.bodyMedium.copyWith(
                    color: AppColors.content_secondary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),

                /// 🔹 Upload File Widget
                FileUploadWidget(
                  status: controller.filePath == null
                      ? FileUploadStatus.initial
                      : FileUploadStatus.success,
                  fileName: controller.filePath != null
                      ? File(controller.filePath!).uri.pathSegments.last
                      : null,
                  fileSize: controller.filePath != null
                      ? File(controller.filePath!).lengthSync() / (1024 * 1024)
                      : null,
                  progress: 1.0,
                  errorMessage: null,
                  onPickFile: () async {
                    final selectedFile = await pickImage();
                    if (selectedFile != null) {
                      controller.onPickFile(selectedFile);
                    }
                  },
                  onRemoveFile: controller.onRemoveFile,
                  onRetry: () async {
                    final selectedFile = await pickImage();
                    if (selectedFile != null) {
                      controller.onPickFile(selectedFile);
                    }
                  },
                  onReplace: () async {
                    final selectedFile = await pickImage();
                    if (selectedFile != null) {
                      controller.onPickFile(selectedFile);
                    }
                  },
                ),

                SizedBox(height: 28.h),

                /// 🔹 Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: PrimaryTextButton(
                    appButtonSize: AppButtonSize.xxLarge,
                    customBackgroundColor: AppColors.action_primary_normal,
                    onTap: controller.filePath != null
                        ? () {
                            Navigator.pop(context);
                            controller.submitData();
                          }
                        : null,
                    label: Text(
                      "continue".tr,
                      style: typography.bodyStrongLarge.copyWith(
                        color: controller.filePath != null
                            ? AppColors.white
                            : AppColors.grayMedium,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                /// 🔹 Cancel Button
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: PrimaryTextButton(
                    appButtonSize: AppButtonSize.xxLarge,
                    customBackgroundColor: AppColors.white,
                    customBorder: BorderSide(
                      width: 1.3,
                      color: AppColors.border_default,
                    ),
                    onTap: () => Navigator.pop(context),
                    label: Text(
                      "cancel".tr,
                      style: typography.bodyStrongLarge.copyWith(
                        color: AppColors.errorForeground,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
