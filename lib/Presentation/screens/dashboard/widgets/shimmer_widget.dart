import 'package:shimmer/shimmer.dart';
import '../../../../index/index_main.dart';

class ForseItemShimmerWidget extends StatelessWidget {
  final bool fromHome;

  const ForseItemShimmerWidget({super.key, this.fromHome = true});

  @override
  Widget build(BuildContext context) {
    final double widthFactor = fromHome ? 0.9 : 0.8;

    return Container(
      width: MediaQuery.of(context).size.width * widthFactor,
      margin: const EdgeInsets.only(left: 12, right: 2, bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
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
            /// 🔹 صورة المشروع (header image)
            Container(
              height: 165.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
              ),
            ),

            SizedBox(height: 12.h),

            /// 🔹 صاحب المشروع + اسم المشروع
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 14.h, width: 120.w, color: AppColors.white),
                  SizedBox(height: 6.h),
                  Container(height: 18.h, width: 180.w, color: AppColors.white),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            /// 🔹 تفاصيل التمويل (3 أعمدة)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (i) {
                  return Column(
                    children: [
                      Container(height: 12.h, width: 50.w, color: AppColors.white),
                      SizedBox(height: 6.h),
                      Container(height: 16.h, width: 60.w, color: AppColors.white),
                    ],
                  );
                }),
              ),
            ),

            SizedBox(height: 16.h),

            /// 🔹 Progress bar placeholder
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 8.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(height: 12.h, width: 60.w, color: AppColors.white),
                      Container(height: 12.h, width: 40.w, color: AppColors.white),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            /// 🔹 الأيام المتبقية
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 14.h, width: 100.w, color: AppColors.white),
                  Container(height: 14.h, width: 50.w, color: AppColors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
