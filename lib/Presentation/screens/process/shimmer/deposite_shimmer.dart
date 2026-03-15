import '../../../../../index/index_main.dart';

class TransactionListShimmerWidget extends StatelessWidget {
  const TransactionListShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border_natural_normal),
            boxShadow: [
              BoxShadow(
                color: AppColors.border_natural_normal.withValues(alpha: 0.15),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 Reference ID
                _shimmerBox(width: 60.w, height: 20.h),
                SizedBox(height: 12.h),

                /// 🔹 Source IBAN
                _shimmerTitleValue(),
                SizedBox(height: 10.h),

                /// 🔹 Amount
                _shimmerTitleValue(),
                SizedBox(height: 10.h),

                /// 🔹 Date
                _shimmerTitleValue(),
                SizedBox(height: 10.h),

                /// 🔹 Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    _shimmerBox(width: 60.w, height: 20.h),
                  ],
                ),
                SizedBox(height: 16.h),

                /// 🔴 Cancel Button Placeholder
                Container(
                  width: double.infinity,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 🔹 Title/Value shimmer row (e.g. "مبلغ العملية" / "1000 ﷼")
  Widget _shimmerTitleValue() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _shimmerBox(width: 100.w, height: 18.h),
        _shimmerBox(width: 80.w, height: 18.h),
      ],
    );
  }

  /// 🔹 Generic shimmer box
  Widget _shimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
