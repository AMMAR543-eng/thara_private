import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thara/Presentation/screens/wallet/bank_accounts/bank_create/upload_widget.dart';
import '../../../../../index/index_main.dart';

class SelectAddressBottomSheet extends StatelessWidget {
  final StoreBankController controller;

  const SelectAddressBottomSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

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
            /// Handle
            Container(
              width: 60.w,
              height: 5.h,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: AppColors.border_default,
                borderRadius: BorderRadius.circular(3),
              ),
            ),

            /// Title
            Text(
              "select_national_address".tr,
              style: typography.headerXLarge.copyWith(
                color: AppColors.content_primary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),

            /// List of Addresses
            SizedBox(
              height: 260.h,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.listAddresses?.length ?? 0,
                separatorBuilder: (_, __) => SizedBox(height: 14.h),
                itemBuilder: (context, index) {
                  final address = controller.listAddresses![index];
                  final isSelected = address == controller.selectedAddress;

                  return Center(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14.r),
                      onTap: () => controller.onAddressSelected(address),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 250.w,
                        height: 260.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border_default.withOpacity(0.6),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.border_default.withOpacity(0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              size: 25.w,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.border_default,
                            ),

                            /// Address info layout
                            Padding(
                              padding: EdgeInsets.only(top: 4.h, right: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Right column (type, district, street)
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildTextRow(
                                          "address_type".tr,
                                          address.isPrimary
                                              ? "primary".tr
                                              : "secondary".tr,
                                          typography,
                                        ),
                                        _buildTextRow(
                                          "district".tr,
                                          address.district ?? "-",
                                          typography,
                                        ),
                                        _buildTextRow(
                                          "street".tr,
                                          address.street ?? "-",
                                          typography,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 10.w),

                                  /// Left column (city, building number)
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildTextRow(
                                          "city".tr,
                                          address.city ?? "-",
                                          typography,
                                          isBold: true,
                                        ),
                                        _buildTextRow(
                                          "building_number".tr,
                                          address.buildingNumber ?? "-",
                                          typography,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 26.h),

            /// Confirm Button
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: PrimaryTextButton(
                appButtonSize: AppButtonSize.xxLarge,
                customBackgroundColor: AppColors.action_primary_normal,
                onTap: () {
                  if (controller.isleanEnable == true) {
                    controller.submitDataWithLean();
                  } else {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) =>
                          UploadProofBottomSheet(controller: controller),
                    );
                  }
                },
                label: Text(
                  "add_account".tr,
                  style: typography.bodyStrongLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10.h),

            /// Cancel Button
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
  }

  /// Address row builder
  Widget _buildTextRow(
    String label,
    String value,
    AppTypography typography, {
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: typography.bodyMedium.copyWith(
              color: AppColors.content_secondary,
            ),
          ),
          Text(
            value,
            style: typography.bodyStrongLarge.copyWith(
              color: AppColors.content_primary,
            ),
          ),
        ],
      ),
    );
  }
}
