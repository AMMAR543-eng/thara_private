import '../../../../../index/index_main.dart';

class BankListViewWidget extends StatelessWidget {
  final ProcessController controller;

  const BankListViewWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final items = controller.bankAccountDataEntity?.bankAccounts ?? [];

    return items.isEmpty
        ? PlaceholderImage(
            image: Images.no_data,
            messege: "No_data".tr,
            isAsset: true,
          )
        : ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(
              height: 0,
              color: AppColors.borderNeutralPrimary,
              thickness: 0.5,
            ),
            itemBuilder: (context, index) {
              final item = items[index];

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.background_neutral_100,
                      child: Icon(
                        Icons.account_balance,
                        color: AppColors.textSecondaryParagraph,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    // 💰 Formatted Amount + Date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            item.alias ?? "",
                            style: context.typography.font33Grey.copyWith(
                              color: AppColors.background_black,
                              height: 0,
                            ),
                          ),
                          Text(
                            item.accountNumber ?? "",
                            style: context.typography.font42Grey.copyWith(
                              color: AppColors.textSecondaryParagraph,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 💰 Formatted Amount + Date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: item.verified == true
                                ? AppColors.successBackground.withOpacity(0.8)
                                : AppColors.yellowBackground.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.verified == true
                                ? "verified".tr
                                : "under_review".tr,
                            style: context.typography.font33Grey.copyWith(
                              color: item.verified == true
                                  ? AppColors.successForeground
                                  : AppColors.yellowForeground,
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        Text(
                          item.bankName ?? "",
                          style: context.typography.font33Grey.copyWith(
                            color: AppColors.textSecondaryParagraph,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }
}
