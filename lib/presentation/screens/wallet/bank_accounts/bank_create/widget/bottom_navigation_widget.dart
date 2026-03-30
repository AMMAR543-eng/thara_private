import '../../../../../../index/index_main.dart';

class BottomNavigationConfirm extends StatelessWidget {
  final StoreBankController controller;

  const BottomNavigationConfirm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10.h),
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
      child: PrimaryTextButton(
        appButtonSize: AppButtonSize.xxLarge,
        label: Text(
          "add_bank_account".tr,
          style: context.typography.font44White.copyWith(
            fontWeight: FontWeight.w600,
            color: controller.isButtonEnabled
                ? AppColors.white
                : AppColors.textFieldBorderDefault,
          ),
        ),
        onTap: controller.isButtonEnabled
            ? () {
          controller.isleanEnable == true
              ? controller.submitDataWithLean()
              : controller.submitData();
        }
            : null,
      ),
    );
  }
}
