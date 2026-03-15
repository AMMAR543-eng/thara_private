import 'dart:io';
import 'package:thara/Global/Utils/upload_file.dart';
import 'package:thara/Presentation/design_systems/widgets/upload_files/fille_upload_widget.dart';
import 'package:thara/index/index_main.dart';
import 'upgradeController.dart';

class Upgradetoprofessionalview extends StatelessWidget {
  const Upgradetoprofessionalview({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "upgrade_to_qualified_investor".tr,
            style: context.typography.headerLarge.copyWith(
              color: AppColors.content_brand_secondary,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Get.back(),
              icon:  Icon(
                Icons.arrow_forward_ios,
                color: AppColors.content_primary,
                size: 18,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: GetBuilder<UploadController>(
            init: UploadController(),
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 Subtitle
                    Text(
                      "upgrade_instructions".tr,
                      style: context.typography.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    /// 🔹 Requirements List
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: ListView.builder(
                          itemCount: _labels.length,
                          itemBuilder: (context, index) {
                            final isSelected = controller.selectedRequirements
                                .contains(index);

                            final filePath = controller.uploadedFiles[index];

                            return Container(
                              margin: EdgeInsets.only(bottom: 15.h),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border: Border.all(
                                        color: AppColors.border_natural_normal,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _labels[index].tr,
                                            style: context.typography.bodyLarge
                                                .copyWith(
                                              color: AppColors
                                                  .formFieldTextLabel,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Checkbox(
                                          value: isSelected,
                                          onChanged: (_) => controller
                                              .selectRequirement(index),
                                          activeColor: AppColors.primary,
                                          side: BorderSide(
                                            color: ColorMappingImpl()
                                                .borderNeutralPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// Upload widget (visible if selected)
                                  if (isSelected) ...[
                                    SizedBox(height: 8.h),
                                    FileUploadWidget(
                                      status: controller.getFileStatus(index),
                                      fileName: filePath != null
                                          ? File(filePath).uri.pathSegments.last
                                          : null,
                                      fileSize: filePath != null
                                          ? File(filePath).lengthSync() /
                                          (1024 * 1024)
                                          : null,
                                      progress:
                                      controller.uploadProgress[index] ??
                                          0.0,
                                      errorMessage:
                                      controller.uploadError[index],
                                      onPickFile: () async {
                                        final selected = await pickImage();
                                        if (selected != null) {
                                          controller.setFile(index, selected);
                                        }
                                      },
                                      onRemoveFile: () =>
                                          controller.removeFile(index),
                                      onRetry: () =>
                                          controller.retryUpload(index),
                                      onReplace: () async {
                                        final selected = await pickImage();
                                        if (selected != null) {
                                          controller.setFile(index, selected);
                                        }
                                      },
                                    ),
                                  ],
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    /// 🔹 Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryTextButton(
                        label: Text(
                          "submit".tr,
                          style: context.typography.bodyLarge.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        onTap: () {
                          if (controller.selectedRequirements.isEmpty) {
                            Loader.showError(
                              "select_at_least_one_requirement".tr,
                            );
                            return;
                          }

                          for (var index in controller.selectedRequirements) {
                            if (controller.uploadedFiles[index] == null) {
                              Loader.showError(
                                "upload_required_documents".tr,
                              );
                              return;
                            }
                          }

                          final param = QualifiedInvestorParam(
                            annualIncomeAndGeneralSecuritiesCertificationRequirement:
                            controller.uploadedFiles[0],
                            netAssetRequirement: controller.uploadedFiles[1],
                            experienceInFinancialSector:
                            controller.uploadedFiles[2],
                            professionalCertificationRequirement:
                            controller.uploadedFiles[3],
                          );

                          controller.uploadData(param);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<String> get _labels => [
    'requirement_annual_income',
    'requirement_net_assets',
    'requirement_experience',
    'requirement_certification',
  ];
}
