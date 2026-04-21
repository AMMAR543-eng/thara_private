import 'package:intl/intl.dart';
import '../../../../../index/index_main.dart';

class HomeInvestCreditTopWidget extends StatelessWidget {
  final double? balance;

  const HomeInvestCreditTopWidget({super.key, this.balance});

  @override
  Widget build(BuildContext context) {
    final formattedBalance = formatNumber(balance, decimals: 2);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 🔹 Title
          Text(
            'your_investment_wallet_balance'.tr,
            style: context.typography.bodyStrongMedium.copyWith(
              color: AppColors.content_secondary,
            ),
            textAlign: TextAlign.center,
          ),

          /// 🔹 Balance + Riyal Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formattedBalance, // ✅ Now shows commas and decimals
                style: context.typography.header4xLarge.copyWith(
                  color: AppColors.content_primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 6.w),
              SvgPicture.asset(
                IconsConstants.riyal,
                height: 30,
                width: 30,
                color: AppColors.content_primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ✅ Locale-aware number formatter
String formatNumber(num? number, {int decimals = 2}) {
  if (number == null) return "0.00";
  final isArabic = LocalStorage_language().read() == "ar";
  final format = NumberFormat.decimalPattern(isArabic ? "ar" : "en");
  format.minimumFractionDigits = decimals;
  format.maximumFractionDigits = decimals;
  return format.format(number);
}
