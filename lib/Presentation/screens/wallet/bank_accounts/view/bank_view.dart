import '../../../../../index/index_main.dart';

class BankAccountCardWidget extends StatelessWidget {
  final String aliasName;
  final String bankName;
  final String accountNumber;
  final String iban;
  final String logo;
  final String status;

  const BankAccountCardWidget({
    super.key,
    required this.aliasName,
    required this.bankName,
    required this.accountNumber,
    required this.iban,
    required this.logo,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    // 🔸 Determine color scheme based on status
    Color backgroundColor, textColor, dotColor;
    switch (status) {
      case "verified":
        backgroundColor = AppColors.successBackground;
        textColor = AppColors.content_positive_secondary;
        dotColor = AppColors.content_positive_secondary;
        break;
      case "under_review":
        backgroundColor = AppColors.background_warning_light;
        textColor = AppColors.tag_icon_warning;
        dotColor = AppColors.tag_icon_warning;
        break;
      case "rejected":
        backgroundColor = AppColors.errorBackground;
        textColor = AppColors.errorForeground;
        dotColor = AppColors.errorForeground;
        break;
      default:
        backgroundColor = AppColors.border_default.withOpacity(0.2);
        textColor = AppColors.content_secondary;
        dotColor = AppColors.content_secondary;
    }

    return Container(
      width: 330.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      margin: EdgeInsets.only(left: 8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border_default),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Header Row (Logo + Bank Name + Status)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 🔹 Bank Logo
              Container(
                width: 42.w,
                height: 42.h,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border_default),
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.white,
                ),
                child: SvgPicture.asset(logo, fit: BoxFit.contain),
              ),

              /// 🔹 Alias Name
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "account_name".tr,
                        style: typography.bodySmall.copyWith(
                          color: AppColors.content_secondary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        aliasName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: typography.bodyStrongMedium.copyWith(
                          color: AppColors.content_primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// 🔹 Status Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: dotColor, size: 8),
                    SizedBox(width: 4.w),
                    Text(
                      status.tr,
                      style: typography.bodyMedium.copyWith(color: textColor),
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// 🔹 Divider
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Divider(color: AppColors.border_default, thickness: 1),
          ),

          /// 🔹 Account Number
          Text(
            "account_number".tr,
            style: typography.bodyMedium.copyWith(
              color: AppColors.content_secondary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            accountNumber,
            style: typography.bodyStrongLarge.copyWith(
              color: AppColors.content_primary,
            ),
          ),

          SizedBox(height: 8.h),

          /// 🔹 IBAN
          Text(
            "iban".tr,
            style: typography.bodyMedium.copyWith(
              color: AppColors.content_secondary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            iban,
            style: typography.bodyStrongLarge.copyWith(
              color: AppColors.content_primary,
            ),
          ),
        ],
      ),
    );
  }
}
