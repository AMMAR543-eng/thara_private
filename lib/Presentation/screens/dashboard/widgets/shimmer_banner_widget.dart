import 'package:shimmer/shimmer.dart';
import '../../../../index/index_main.dart';

class DashboardBannerShimmerWidget extends StatelessWidget {
  const DashboardBannerShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 28.h,
                      width: 200.w,
                      color: AppColors.white,
                    ),
                    SizedBox(height: 15.h),
                    Container(
                      height: 24.h,
                      width: 150.w,
                      color: AppColors.white,
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      height: 36.h,
                      width: 100.w,
                      color: AppColors.white,
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      height: 20.h,
                      width: 140.w,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ),
            SvgPicture.asset(
              IconsConstants.homeBuilding,
              fit: BoxFit.contain,
              height: 90,
            ),
            SizedBox(width: 30.w),
          ],
        ),
      ),
    );
  }
}
