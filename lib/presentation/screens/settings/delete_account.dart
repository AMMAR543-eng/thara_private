import '../../../../index/index_main.dart';

/// This dialog returns either:
/// - a `String` (selected type key)
/// - or a `Map<String, dynamic>` containing { "type": "other", "reason": "..." }

Future<dynamic> showDeactivateAccountDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const _DeactivateAccountDialog(),
  );
}

class _DeactivateAccountDialog extends StatefulWidget {
  const _DeactivateAccountDialog({super.key});

  @override
  State<_DeactivateAccountDialog> createState() =>
      _DeactivateAccountDialogState();
}

class _DeactivateAccountDialogState extends State<_DeactivateAccountDialog> {
  String? selectedReason;
  final TextEditingController _otherReasonController = TextEditingController();

  final Map<String, String> reasons = {
    "need_more_info": "لم أفهم طريقة التمويل أو الضمانات بشكل كامل.",
    "hard_to_use": "واجهت صعوبة في استخدام المنصة.",
    "an_issue": "واجهت تأخيرًا أو مشكلة في عملية الاستثمار أو السحب.",
    "no_fit_products": "أرغب بالاستثمار في منتجات أخرى غير موجودة في منصة ذرى.",
    "other": "أسباب أخرى",
  };

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 🔹 Header
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.errorForeground,
                    size: 28.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "إيقاف الحساب",
                    style: typography.headerLarge.copyWith(
                      color: AppColors.content_primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              /// 🔹 Description
              Text(
                "أنت على وشك إيقاف حسابك، لن تتمكن من الوصول إليه مرة أخرى. هل أنت متأكد من إيقاف الحساب؟",
                style: typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),

              /// 🔹 Choose reason
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "إختر سبب واحد على الأقل:",
                  style: typography.bodyLarge.copyWith(
                    color: AppColors.content_primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              /// 🔹 Radio options
              Column(
                children: reasons.entries.map((entry) {
                  return RadioListTile<String>(
                    value: entry.key,
                    groupValue: selectedReason,
                    onChanged: (val) => setState(() => selectedReason = val),
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColors.errorForeground,
                    title: Text(
                      entry.value,
                      style: typography.bodyMedium.copyWith(
                        color: AppColors.content_secondary,
                      ),
                    ),
                  );
                }).toList(),
              ),

              /// 🔹 "Other reason" text field
              if (selectedReason == "other") ...[
                SizedBox(height: 10.h),
                TextField(
                  controller: _otherReasonController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "يرجى توضيح السبب...",
                    hintStyle: typography.bodyMedium.copyWith(
                      color: AppColors.tertiary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: AppColors.border_natural_normal,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: AppColors.errorForeground,
                      ),
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  ),
                ),
              ],

              SizedBox(height: 20.h),

              /// 🔹 Buttons
              Row(
                children: [
                  /// Cancel
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: AppColors.border_natural_normal,
                          width: 1.2,
                        ),
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Text(
                        "إلغاء",
                        style: typography.bodyLarge.copyWith(
                          color: AppColors.background_black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),

                  /// Confirm
                  Expanded(
                    child: ElevatedButton(
                      onPressed: selectedReason == null
                          ? null
                          : () {
                        // If "other" selected and reason text exists
                        if (selectedReason == "other" &&
                            _otherReasonController.text.isNotEmpty) {
                          Navigator.pop(context, {
                            "type": selectedReason,
                            "reason": _otherReasonController.text,
                          });
                        } else {
                          Navigator.pop(context, selectedReason);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.errorForeground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Text(
                        "تأكيد إيقاف الحساب",
                        style: typography.bodyLarge.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
