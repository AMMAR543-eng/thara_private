import '../../../../../index/index_main.dart';

class RegisterInfoScreen extends StatefulWidget {
   bool? isCompany;

   RegisterInfoScreen({super.key, this.isCompany});

  @override
  State<RegisterInfoScreen> createState() => _RegisterInfoScreenState();
}

class _RegisterInfoScreenState extends State<RegisterInfoScreen> {
  final formInfoKey = GlobalKey<FormState>();
  late final RegisterController registerController;

  @override
  void initState() {
    String account_type = const AccountModel().getAccountLocal()?.type ?? "";
    bool is_local_account_company = account_type == "company" ?true:false;
    widget.isCompany = is_local_account_company;
    print("account type is $is_local_account_company");
    registerController = initUseCase(() => RegisterController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isCompany = widget.isCompany == true;

    return GetBuilder<RegisterInfoController>(
      init: RegisterInfoController(),
      builder: (controller) {
        return SingleChildScrollView(
          child: Form(
            key: formInfoKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// --- Section Title
                Text(
                  "register_info_basic".tr,
                  style: context.typography.headerXLarge.copyWith(
                    color: AppColors.content_brand_secondary,
                  ),
                ),
                SizedBox(height: 20.h),

                /// -------------------------
                /// COMMON (individual fields)
                /// -------------------------
                GetBuilder<RegisterInfoController>(
                  builder: (_) {
                    return GenericNewDropdown<GenericListModel>(
                      title: "register_info_nationality".tr,
                      hint: "register_info_nationality_hint".tr,
                      items: controller.listCitizenShip ?? [],
                      selectedItem: controller.selectedCitizenShip,
                      itemLabel: (item) => item.name_ar ?? item.name ?? "",
                      onChanged: controller.onCitizenShipSelected,
                      isRequired: true,
                    );
                  },
                ),
                SizedBox(height: 16.h),

                /// National ID
                TextInputWidget(
                  title: "register_info_id_label".tr,
                  appTextField: AppTextField(
                    controller: controller.idController,
                    hintText: "register_info_id_hint".tr,
                    validator: InputValidators.combine([
                      notEmptyValidator,
                      InputValidators.validateIdentityNumber,
                    ]),
                    keyboardType: TextInputType.number,
                    onValidationChanged: (value) =>
                        controller.setValidation(id: value),
                  ),
                ),
                SizedBox(height: 16.h),

                /// Phone
                TextInputWidget(
                  title: "register_info_phone_label".tr,
                  appTextField: AppTextField(
                    controller: controller.phoneController,
                    hintText: "register_info_phone_hint".tr,
                    validator: InputValidators.combine([
                      notEmptyValidator,
                      InputValidators.validateSaudiPhone,
                    ]),
                    keyboardType: TextInputType.phone,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Text(
                        "966+",
                        style: context.typography.bodyLarge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      controller.completePhone = "0$value";
                      controller.setValidation(phone: value.isNotEmpty);
                      controller.update();
                    },
                    onValidationChanged: (value) =>
                        controller.setValidation(phone: value),
                  ),
                ),
                SizedBox(height: 16.h),

                /// Birthday
                TextInputWidget(
                  title: "register_info_birthdate_label".tr,
                  appTextField: AppTextField(
                    controller: controller.dateController,
                    read_only: true,
                    hintText: "register_info_birthdate_hint".tr,
                    ontap: () {
                      showCustomBottomSheet(
                        isDismissible: true,
                        context: context,
                        padding: EdgeInsets.zero,
                        child: CalendarPickerView(
                          controller: controller.dateController,
                          getxController: controller,
                        ),
                      );
                    },
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(IconsConstants.date),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                /// Hijri Equivalent
                if (controller.hijriEquivalent != null &&
                    controller.hijriEquivalent!.isNotEmpty)
                  TextInputWidget(
                    title: "register_info_hijri_label".tr,
                    appTextField: AppTextField(
                      controller: TextEditingController(
                        text: controller.hijriEquivalent,
                      ),
                      read_only: true,
                      hintText: "register_info_hijri_hint".tr,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(IconsConstants.date),
                      ),
                    ),
                  ),
                SizedBox(height: 20.h),

                /// -------------------------
                /// COMPANY FIELDS (from old UI)
                /// -------------------------
                if (isCompany) ...[
                  TextInputWidget(
                    title: "companyName".tr,
                    appTextField: AppTextField(
                      controller: controller.companyController,
                      validator: notEmptyValidator,
                      onValidationChanged: (value) =>
                          controller.setValidation(companyName: value),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  TextInputWidget(
                    title: "companyRecord".tr,
                    appTextField: AppTextField(
                      controller: controller.commercialController,
                      keyboardType: TextInputType.number,
                      validator: InputValidators.combine([
                        notEmptyValidator,
                        InputValidators.validateIdentityNumber,
                      ]),
                      onValidationChanged: (value) =>
                          controller.setValidation(commercial: value),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  TextInputWidget(
                    title: "uniNumber".tr,
                    appTextField: AppTextField(
                      controller: controller.numberController,
                      keyboardType: TextInputType.number,
                      validator: InputValidators.combine([
                        notEmptyValidator,
                        InputValidators.validateIdentityNumber,
                      ]),
                      onValidationChanged: (value) =>
                          controller.setValidation(unified: value),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  GetBuilder<RegisterInfoController>(
                    builder: (_) {
                      return GenericNewDropdown<GenericListModel>(
                        title: "activityType".tr,
                        hint: "activityType".tr,
                        items: controller.listCompanyType ?? [],
                        selectedItem: controller.selectedCompanyType,
                        itemLabel: (item) => item.name_ar ?? item.name ?? "",
                        onChanged: controller.onCompanyTypeSelected,
                        isRequired: true,
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],

                /// Digital Signature
                DigitalSignatureAgreementWidget(
                  onPreview: () {
                    Get.to(
                      () => GenericPdfViewerFromAsset(
                        assetPath: 'assets/register_basic_info.pdf',
                        title: 'التوقيع الرقمي لإتفاقية الإشتراك'.tr,
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),

                /// Terms
                Obx(
                  () => Row(
                    children: [
                      GestureDetector(
                        onTap: controller.acceptSignatureAction,
                        child: Container(
                          width: 22.w,
                          height: 22.h,
                          decoration: BoxDecoration(
                            color: controller.acceptSignature.value
                                ? AppColors.primary
                                : Colors.transparent,
                            border: Border.all(
                              color: controller.acceptSignature.value
                                  ? AppColors.primary
                                  : AppColors.darkGray,
                              width: 1.8,
                            ),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: controller.acceptSignature.value
                              ? Icon(
                                  Icons.check,
                                  size: 16.sp,
                                  color: AppColors.white,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          "register_info_terms".tr,
                          style: context.typography.bodyMedium.copyWith(
                            color: AppColors.content_primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /// Terms
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Obx(
                        () => Row(
                      children: [
                        GestureDetector(
                          onTap: controller.acceptCreditsAction,
                          child: Container(
                            width: 22.w,
                            height: 22.h,
                            decoration: BoxDecoration(
                              color: controller.acceptCredits.value
                                  ? AppColors.primary
                                  : Colors.transparent,
                              border: Border.all(
                                color: controller.acceptCredits.value
                                    ? AppColors.primary
                                    : AppColors.darkGray,
                                width: 1.8,
                              ),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: controller.acceptCredits.value
                                ? Icon(
                              Icons.check,
                              size: 16.sp,
                              color: AppColors.white,
                            )
                                : null,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            "register_credit_terms".tr,
                            style: context.typography.bodyMedium.copyWith(
                              color: AppColors.content_primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Submit Button
                GetBuilder<RegisterInfoController>(
                  builder: (controller) {
                    final bool isEnabled = isCompany
                        ? controller.isValidCompany()
                        : controller.isValidIndividual();

                    return SizedBox(
                      width: ScreenUtil().screenWidth,
                      child: PressAnimatedButton(
                        backgroundColor: AppColors.primary_normal,
                        disabledColor: AppColors.buttonDisabledColor,
                        borderRadius: BorderRadius.circular(10),
                        label: Text(
                          "next".tr,
                          style: context.typography.bodyLarge.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        onTap: isEnabled
                            ? () {
                                controller.submit(
                                  isCompany: isCompany,
                                  formKey: formInfoKey,
                                );
                              }
                            : null,
                      ),
                    );
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
