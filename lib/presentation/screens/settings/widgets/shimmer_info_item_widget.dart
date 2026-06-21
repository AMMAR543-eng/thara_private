import '../../../../../index/index_main.dart';

class InfoListShimmerWidget extends StatelessWidget {
  const InfoListShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      // number of shimmer items
      separatorBuilder: (_, __) {
        return Divider(
          color: AppColors.grayMedium.withAlpha(30),
          endIndent: 20.h,
          indent: 20.h,
        );
      },
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _shimmerBox(width: 100.w, height: 40.h),
                  SizedBox(height: 20.h),
                  _shimmerBox(width: 150.w, height: 40.h),
                ],
              ),
              const Spacer(),
              _shimmerBox(width: 40.w, height: 40.h),
            ],
          ),
        );
      },
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
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
