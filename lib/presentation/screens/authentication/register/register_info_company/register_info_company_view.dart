import 'package:thara/Presentation/design_systems/widgets/date_picker/date_picker_general.dart';
import 'package:thara/Presentation/screens/authentication/register/register_info_company/register_info_company_controller.dart';

import '../../../../../index/index_main.dart';

class RegisterCompanyInfoScreen extends StatefulWidget {
  const RegisterCompanyInfoScreen({super.key});

  @override
  State<RegisterCompanyInfoScreen> createState() => _RegisterCompanyInfoScreenState();
}

class _RegisterCompanyInfoScreenState extends State<RegisterCompanyInfoScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterCompanyInfoController>(
      init: RegisterCompanyInfoController(),
      builder: (controller) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  "المعلومات الأساسية",
                  style: context.typography.headerLarge.copyWith(
                    color: AppColors.content_brand_secondary,
                  ),
                ),
                SizedBox(height: 20.h),

                /// --- Unified Number
                TextInputWidget(
                  title: "رقم السجل الموحد",
                  appTextField: AppTextField(
                    controller: controller.unifiedController,
                    hintText: "ادخل رقم السجل الموحد",
                    validator: notEmptyValidator,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => controller.checkIfReady(),
                  ),
                ),
                SizedBox(height: 16.h),

                /// --- Expiry Date
                TextInputWidget(
                  title: "تاريخ انتهاء السجل التجاري",
                  appTextField: AppTextField(
                    controller: controller.expiryController,
                    hintText: "ادخل تاريخ انتهاء السجل التجاري",
                    read_only: true,
                    ontap: () {
                      showCustomBottomSheet(
                        context: context,
                        child: CalendarPickerGeneralView(
                          controller: controller.expiryController,
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

                /// --- Company Info (only after valid inputs)
                if (controller.companyInfo != null) ...[
                  _buildInfoCard(
                    context,
                    "معلومات الشركة المدخلة",
                    {
                      "اسم الشركة": controller.companyInfo!.name,
                      "نشاط الشركة": controller.companyInfo!.activity,
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildInfoCard(
                    context,
                    "العنوان الوطني للشركة المدخلة",
                    {
                      "المدينة": controller.companyInfo!.city,
                      "الحي": controller.companyInfo!.district,
                      "رقم المبنى": controller.companyInfo!.buildingNo,
                      "الشارع": controller.companyInfo!.street,
                    },
                  ),
                ],

                SizedBox(height: 30.h),

                /// --- Next button
                SizedBox(
                  width: double.infinity,
                  child: PressAnimatedButton(
                    backgroundColor: AppColors.primary,
                    borderRadius: BorderRadius.circular(12.r),
                    label: Text(
                      "التالي",
                      style: context.typography.bodyLarge.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    onTap: controller.isFormValid
                        ? () {
                      controller.submit(formKey);
                    }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, Map<String, String> fields) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderNeutralPrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: context.typography.bodyStrongLarge.copyWith(
                color: AppColors.content_brand_secondary,
              )),
          SizedBox(height: 12.h),
          ...fields.entries.map(
                (e) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Text(
                "${e.key}: ${e.value}",
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
