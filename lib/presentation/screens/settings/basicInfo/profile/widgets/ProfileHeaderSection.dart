import '../../../../../../index/index_main.dart';

class ProfileHeaderSection extends StatelessWidget {
  final String? imageUrl;
  final String fullNameAr;
  final String accountId;
  final bool showVerifiedIcon;

  const ProfileHeaderSection({
    super.key,
    this.imageUrl,
    required this.fullNameAr,
    required this.accountId,
    this.showVerifiedIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// --- Profile Image + Verified Icon
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 45.r,
                backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                    ? NetworkImage(imageUrl!)
                    : const NetworkImage(''),
              ),
              if (showVerifiedIcon)
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      IconsConstants.owner,
                      height: 16.h,
                      width: 16.h,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: 10.h),

          /// --- Full Name (Arabic)
          Text(
            fullNameAr,
            style: typography.headerXLarge.copyWith(color: AppColors.primary),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 4.h),

          /// --- Account ID
          Text(
            accountId,
            style: typography.bodyMedium.copyWith(color: AppColors.tertiary),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
