import '../../../../index/index_main.dart';

class WalletBannerShimmerWidget extends StatelessWidget {
  const WalletBannerShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 45.w),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        gradient:  const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF003B3A), Colors.black],
        ),
      ),
      child: Column(
        children: [
          /// 🔝 Top balance row
          Row(
            children: [
              /// Left - Balance details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmerBox(width: 160.w, height: 40.h), // "رصيد المحفظة"
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        _shimmerBox(width: 180.w, height: 90.h), // 15,890.59
                        SizedBox(width: 10.w),
                        _shimmerCircle(size: 50.w), // Icon
                      ],
                    ),
                  ],
                ),
              ),

              /// Right - Eye icon
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withOpacity(0.1),
                ),
                child: _shimmerBox(width: 30.w, height: 30.w),
              ),
            ],
          ),

           Divider(color: AppColors.primary, thickness: 0.5),
          SizedBox(height: 20.h),

          /// 🔻 Bottom rows: available + reserved
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _buildStatColumnShimmer()),
              Container(height: 90.h, width: 0.5, color: AppColors.primary),
              Expanded(child: _buildStatColumnShimmer()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumnShimmer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _shimmerBox(width: 100.w, height: 49.h), // value
            SizedBox(width: 6.w),
            _shimmerCircle(size: 50.w), // Icon
          ],
        ),
        SizedBox(height: 12.h),
        _shimmerBox(width: 120.w, height: 44.h), // subtitle
      ],
    );
  }

  Widget _shimmerBox({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  Widget _shimmerCircle({required double size}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
