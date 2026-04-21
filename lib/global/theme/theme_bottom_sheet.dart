import '../../index/index_main.dart';

Future<void> showThemeBottomSheet(BuildContext context) async {
  final storage = LocalStorageTheme();
  final currentTheme = storage.read();

  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'theme'.tr,
                style: context.typography.bodyLarge.copyWith(
                  color: AppColors.textDefault,
                ),
              ),
              const SizedBox(height: 20),
              _themeTile(
                title: 'light_mode'.tr,
                selected: currentTheme == 'light',
                onTap: () {
                  storage.insert('light');
                  Get..changeThemeMode(ThemeMode.light)
                  ..offAllNamed(mainPage);
                },
              ),
              _themeTile(
                title: 'dark_mode'.tr,
                selected: currentTheme == 'dark',
                onTap: () {
                  storage.insert('dark');
                  Get.changeThemeMode(ThemeMode.dark);
                  Get.offAllNamed(mainPage);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _themeTile({
  required String title,
  required bool selected,
  required VoidCallback onTap,
}) {
  return ListTile(
    title: Text(title, style: TextStyle(color: AppColors.primary)),
    trailing: selected ? Icon(Icons.check, color: AppColors.primary) : null,
    onTap: onTap,
  );
}
