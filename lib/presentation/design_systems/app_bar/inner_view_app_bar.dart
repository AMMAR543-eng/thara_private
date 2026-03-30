import '../../../index/index_main.dart';

class InnerViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const InnerViewAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.border_natural_normal.withValues(alpha: 1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: preferredSize.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// 🔹 Centered title
                Text(
                  title,
                  style: context.typography.bodyStrongLarge.copyWith(
                    color: AppColors.content_brand_secondary,
                  ),
                  textAlign: TextAlign.center,
                ),

                /// 🔹 Left back button + label
                InkWell(
                  onTap: () => Get.back(),

                  child: Align(
                    alignment: LocalStorage_language().read() == "en"
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color:
                          Theme.of(Get.context!).brightness == Brightness.dark
                          ? Colors.white
                          : AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
