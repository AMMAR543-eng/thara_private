import '../../../../index/index_main.dart';

class BannerImagesCursoul extends StatelessWidget {
  final List<ProjectImage>? images;

  const BannerImagesCursoul({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40.h),
      height: 300.h,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: images?.length ?? 0,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          String image = images?[index].url ?? "";
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: image.length <= 1
                ? NetworkAttachmentImage(
                    width: ScreenUtil().screenWidth - 60.w,
                    height: 300,
                    url: image ?? "",
                  )
                : NetworkAttachmentImage(
                    url: image ?? "",
                    width: ScreenUtil().screenWidth - 100.w,
                    height: 300,
                  ),
          );
        },
      ),
    );
  }
}
