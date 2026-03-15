import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thara/index/index.dart';

class InvestmentPortfolioBanner extends StatelessWidget {
  final String userName;
  final double walletValue;
  final double revenue;
  final double revenueRate;
  final VoidCallback onViewMore;

  const InvestmentPortfolioBanner({
    super.key,
    required this.userName,
    required this.walletValue,
    required this.revenue,
    required this.revenueRate,
    required this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0C3C3D),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text("investment_portfolio".tr, style: context.typography.font52Grey),
          SizedBox(height: 16.h),

          /// Info Row
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  _InfoBlock(
                    label: "wallet_value".tr,
                    value: "${walletValue.toStringAsFixed(2)} SAR",
                  ),
                  _VerticalDivider(height: 70.h),
                  _InfoBlock(
                    label: "revenue".tr,
                    value: "${revenue.toStringAsFixed(2)} SAR",
                  ),
                  _VerticalDivider(height: 70.h),
                  _InfoBlock(
                    label: "revenue_rate".tr,
                    value: "${revenueRate.toStringAsFixed(1)} %",
                    icon: Icons.arrow_drop_up,
                    iconColor: Colors.green,
                  ),
                ],
              );
            },
          ),

          SizedBox(height: 16.h),

          /// View More
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: onViewMore,
                child: Text(
                  "view_more".tr,
                  style: context.typography.font42Grey.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;

  const _InfoBlock({
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: context.typography.font49Red.copyWith(
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: context.typography.font49Red.copyWith(
                  color: AppColors.white,
                ),
              ),
              if (icon != null)
                Icon(icon, size: 60.sp, color: iconColor ?? Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  final double height;

  const _VerticalDivider({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 1,
      color: Colors.teal.shade700,
      margin: EdgeInsets.symmetric(horizontal: 12.w),
    );
  }
}
