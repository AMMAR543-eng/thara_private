import 'package:thara/Presentation/screens/process/all_trnsactions/bank_accounts_view.dart';
import '../../../../index/index_main.dart';

class DashboardBannerWidget extends StatelessWidget {
  final TradeAccountEntity tradeAccountEntity;
  final int banktotal;

  const DashboardBannerWidget({
    super.key,
    required this.tradeAccountEntity,
    required this.banktotal,
  });

  @override
  Widget build(BuildContext context) {
    final String? token = LoginResponseModel()
        .getTokenData()
        ?.data
        ?.accessToken;
    final bool isGuest = token == null;

    final bool hasTotal = !isGuest && tradeAccountEntity.total != null;
    final bool needsBankAccount = !isGuest && banktotal == 0;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 260.h,
      decoration: BoxDecoration(
        color: AppColors.mediumJungleGreen,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(128),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SizedBox(width: 10.w),
            Expanded(
              child: isGuest
                  ? _buildGuestContent(context)
                  : (needsBankAccount
                        ? _buildBankAccountNotice(context)
                        : _buildDefaultOrTotal(context, hasTotal)),
            ),
            InkWell(
              onTap: !hasTotal
                  ? null
                  : () {
                      Get.offAll(
                        () => MainPage(indexNum: 1),
                        binding: Binding(),
                        duration: const Duration(milliseconds: 0),
                      );
                    },
              child: SvgPicture.asset(
                IconsConstants.homeBuilding,
                fit: BoxFit.contain,
                height: 90,
              ),
            ),
            SizedBox(width: 30.w),
            Visibility(
              visible: hasTotal,
              child: InkWell(
                onTap: !hasTotal
                    ? null
                    : () {
                        Get.offAll(
                          () => MainPage(indexNum: 1),
                          binding: Binding(),
                          duration: const Duration(milliseconds: 0),
                        );
                      },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "partner_in_real_estate".tr,
          style: context.typography.font52Grey.copyWith(
            color: AppColors.whiteSmoke,
          ),
        ),
        SizedBox(height: 15.h),
        Expanded(
          child: Text(
            "start_investment_journey".tr,
            style: context.typography.font52Grey.copyWith(
              color: AppColors.whiteSmoke,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultOrTotal(BuildContext context, bool hasTotal) {
    return InkWell(
      onTap: !hasTotal
          ? null
          : () {
              Get.offAll(
                () => MainPage(indexNum: 1),
                binding: Binding(),
                duration: const Duration(milliseconds: 0),
              );
            },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hasTotal
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${tradeAccountEntity.total}",
                          style: context.typography.montserratBlack62White,
                        ),
                        SizedBox(width: 6.w),
                        SvgPicture.asset(
                          IconsConstants.riyal,
                          width: 60.w,
                          height: 60.h,
                          color: AppColors.content_primary,

                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'total_investments'.tr,
                      style: context.typography.font49Grey.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "partner_in_real_estate".tr,
                      style: context.typography.font52Grey.copyWith(
                        color: AppColors.whiteSmoke,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      "investment_opportunities".tr,
                      style: context.typography.font52Grey.copyWith(
                        color: AppColors.whiteSmoke,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildBankAccountNotice(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "bank_account_required".tr,
          style: context.typography.font42Grey.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: SizedBox(
            width: 400.w,
            child: PrimaryTextButton(
              onTap: () {
                Get.to(() => const BankAccountsView());
              },
              label: Text(
                "create_bank_account".tr,
                style: context.typography.font42Grey.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
