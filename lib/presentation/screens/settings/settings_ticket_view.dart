import 'package:thara/Presentation/screens/settings/ContactUs/contact_section_widget.dart';
import 'package:thara/index/index_main.dart';
import '../authentication/register/widgets/phone_widget.dart';

class SettingsTicketView extends StatefulWidget {
  const SettingsTicketView({super.key});

  @override
  State<SettingsTicketView> createState() => _SettingsTicketViewState();
}

class _SettingsTicketViewState extends State<SettingsTicketView> {
  final formTicketKey = GlobalKey<FormState>();
  final phoneWidget = GlobalKey<FormState>();
  late GenericKeyboardManager<String> keyboardManager;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  FocusNode focusNode = FocusNode();

  bool validName = false;
  bool validMessage = false;
  bool validPhone = false;

  @override
  void initState() {
    keyboardManager = GenericKeyboardManager<String>(nodeCount: 3);
    super.initState();
  }

  @override
  void dispose() {
    keyboardManager.dispose();
    nameController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: InnerViewAppBar(title: "new_ticket".tr),
      body: GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (controller) {
          final map = controller.infoMap;

          return SafeArea(
            child: Form(
              key: formTicketKey,
              child: KeyboardActions(
                config: keyboardManager.buildConfig(),
                disableScroll: true,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 24.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// --- Info Box
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.background_neutral_surface,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          "working_hours_notice".tr,
                          style: typography.bodyMedium.copyWith(
                            color: AppColors.content_secondary,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 30.h),

                      /// --- Full Name Label
                      Text(
                        "full_name".tr,
                        style: typography.bodyStrongLarge.copyWith(
                          color: AppColors.content_primary,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      /// --- Full Name Field
                      AppTextField(
                        controller: nameController,
                        hintText: "enter_full_name".tr,
                        keyboardType: TextInputType.name,
                        validator: InputValidators.combine([notEmptyValidator]),
                        onValidationChanged: (value) {
                          setState(() => validName = value);
                        },
                      ),
                      SizedBox(height: 20.h),

                      /// --- Phone Label
                      Text(
                        "phone_number".tr,
                        style: typography.bodyStrongLarge.copyWith(
                          color: AppColors.content_primary,
                        ),
                      ),

                      /// --- Phone Field
                      AppTextField(
                        controller: phoneController,
                        hintText: "enter_phone_number".tr,
                        keyboardType: TextInputType.phone,
                        validator: InputValidators.combine([
                          notEmptyValidator,
                          InputValidators.validateSaudiPhone,
                        ]),
                        onValidationChanged: (value) {
                          setState(() => validPhone = value);
                        },
                      ),
                      SizedBox(height: 20.h),

                      /// --- Ticket Type Dropdown
                      GenericDropdown<GenericListModel>(
                        hint_text: 'select_ticket_type'.tr,
                        title: 'ticket_type'.tr,
                        items: controller.listTicketTypes ?? [],
                        initialValue: controller.selectedTicketType,
                        onChanged: controller.onTicketSelected,
                        displayItemBuilder: (item) => Text(
                          item.name ?? "",
                          style: typography.bodyLarge.copyWith(
                            color: AppColors.content_primary,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),

                      /// --- Message Label
                      Text(
                        "message".tr,
                        style: typography.bodyStrongLarge.copyWith(
                          color: AppColors.content_primary,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      /// --- Message Field
                      AppTextField(
                        controller: messageController,
                        hintText: "write_message".tr,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        validator: InputValidators.combine([notEmptyValidator]),
                        onValidationChanged: (value) {
                          setState(() => validMessage = value);
                        },
                      ),
                      SizedBox(height: 40.h),

                      /// --- Send Button
                      SizedBox(
                        width: ScreenUtil().screenWidth,
                        child: PrimaryTextButton(
                          appButtonSize: AppButtonSize.xlarge,
                          onTap: validName &&
                                  validPhone &&
                                  validMessage &&
                                  controller.selectedTicketType?.id != null
                              ? () {
                                  if (formTicketKey.currentState?.validate() ??
                                      false) {
                                    controller.storeTicketApi(
                                      nameController.text,
                                      phoneController.text,
                                      controller.selectedTicketType!.name_ar!,
                                      messageController.text,
                                    );
                                  }
                                }
                              : null,
                          label: Text(
                            "send".tr,
                            style: typography.bodyLarge.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      /// --- Contact Info Section
                      // ContactSectionWidget(map: map),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
