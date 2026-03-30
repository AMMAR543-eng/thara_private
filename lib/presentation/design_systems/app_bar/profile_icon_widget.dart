import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../index/index_main.dart';

class ProfileIconWidget extends StatelessWidget {
  final double size;
  final Color? borderColor;
  final Color? backgroundColor;
  final bool enableEdit;

  const ProfileIconWidget({
    super.key,
    this.size = 90,
    this.borderColor,
    this.backgroundColor,
    this.enableEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Obx(() {
      final imageUrl = controller.profileUrl.value;

      return GestureDetector(
        onTap: enableEdit ? controller.changeProfilePhoto : null,
        child: Container(
          width: size.w,
          height: size.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor ?? AppColors.white,
            border: Border.all(
              color: borderColor ??
                  AppColors.border_natural_normal.withValues(alpha: 0.3),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: ClipOval(
            child: imageUrl.isEmpty
                ? Icon(
              Icons.person,
              size: size * 0.45,
              color: AppColors.content_secondary,
            )
                : CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: size.w,
              height: size.w,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.person,
                size: size * 0.45,
                color: AppColors.content_secondary,
              ),
            ),
          ),
        ),
      );
    });
  }
}

/// ✅ Controller responsible for profile image data
class ProfileController extends GetxController {
  RxString profileUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadProfilePhoto();
  }

  void _loadProfilePhoto() {
    final localUser = AccountModel().getAccountLocal();
    profileUrl.value = localUser?.profilePhoto?.url ?? "";
  }

  Future<void> changeProfilePhoto() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (picked == null) return;

      final imageFile = File(picked.path);

      AuthService().uploadProfileImage(
        imagePath: imageFile.path,
        voidCallBack: (data) {
          Loader.showSuccess("تم تحديث الصورة بنجاح ✅");
          _loadProfilePhoto();
        },
      );
    } catch (e) {
      Loader.showError("حدث خطأ أثناء رفع الصورة");
    }
  }
}
