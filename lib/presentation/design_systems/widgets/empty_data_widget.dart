import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thara/index/index.dart';

class PlaceholderImage extends StatelessWidget {
  final String image;
  final String messege;
  final bool? isAsset;

  const PlaceholderImage({
    Key? key,
    required this.image,
    required this.messege,
    this.isAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // isAsset == true
            //     ? ClipRRect(
            //         borderRadius: BorderRadius.circular(20),
            //         child: Image.asset(image, width: 500.w, height: 500.h),
            //       )
            //     : SvgPicture.asset(image),
            SizedBox(height: 15.h),
            Text(
              messege,
              style: context.typography.headerXLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
