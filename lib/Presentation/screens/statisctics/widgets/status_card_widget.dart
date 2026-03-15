import '../../../../index/index_main.dart';

class StatusCard extends StatelessWidget {
  final String amount;
  final String label;
  final Color color;
  final Color? amountColor;

  const StatusCard({super.key, 
    required this.amount,
    required this.label,
    required this.color,
    this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 250.h,
                width: 230.w,
                child: const CircularProgressIndicator(
                  value: 0.7,
                  backgroundColor: Colors.black12,
                  strokeWidth: 6,
                  valueColor: AlwaysStoppedAnimation(AppColors.greyDark),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    amount,
                    style: context.typography.font52Grey.copyWith(
                      color: amountColor ?? AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SvgPicture.asset(
                    IconsConstants.riyal,
                    height: 50.h,
                    width: 50.w,
                    color: amountColor,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Text(
            label,
            style: context.typography.font33Grey.copyWith(
              color: AppColors.background_black,
            ),
          ),
        ],
      ),
    );
  }
}
