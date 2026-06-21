import '../../../../index/index_main.dart';

class GenericLanguageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const GenericLanguageAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,

      // 🌐 left: language
      leadingWidth: 56,
      leading: IconButton(
        icon: const Icon(Icons.language, size: 25),
        color: AppColors.primary,
        onPressed: () {
          //   final controller = initUseCase(() => AppLanguage());
          final controller = Get.find<AppLanguage>();

          final currentLang = LocalStorage_language().read();

          if (currentLang == 'ar') {
            controller.changeLanguage('en');
          } else {
            controller.changeLanguage('ar');
          }
        },
      ),

      // 📝 title
      title: Text(
        title.tr,
        style: context.typography.headerXLarge.copyWith(
          color: AppColors.content_brand_secondary,
        ),
      ),

      // ➡️ right: back
      actions: [
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios, size: 20),
          color: AppColors.primary,
          onPressed: () => Get.offAllNamed(loginScreen),
        ),
      ],

      // thin divider
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: AppColors.border_natural_normal),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
