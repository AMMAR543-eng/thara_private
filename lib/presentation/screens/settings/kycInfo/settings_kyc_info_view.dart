import 'package:thara/index/index_main.dart';

class SettingsKYCInfoView extends StatefulWidget {
  const SettingsKYCInfoView({super.key});

  @override
  State<SettingsKYCInfoView> createState() => _SettingsKYCInfoViewState();
}

class _SettingsKYCInfoViewState extends State<SettingsKYCInfoView> {
  String? _contractorType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          "kyc_form".tr,
          textAlign: TextAlign.center,
          style: context.typography.font55GreyLeft.copyWith(
            color: AppColors.background_black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: ExpansionTileCard(
                  elevation: 1,
                  title: Text(
                    'job_status'.tr,
                    style: context.typography.font52Grey.copyWith(
                      color: AppColors.darkGray,
                    ),
                  ),
                  initiallyExpanded: true,
                  children: [
                    ExpansionItemWidget(
                      title: 'government_sector'.tr,
                      value: 'government',
                      groupValue: _contractorType,
                      onChanged: (value) {
                        setState(() => _contractorType = value);
                      },
                    ),
                    const Divider(thickness: 1.0, height: 1.0),
                    ExpansionItemWidget(
                      title: 'private_sector'.tr,
                      value: 'special',
                      groupValue: _contractorType,
                      onChanged: (value) {
                        setState(() => _contractorType = value);
                      },
                    ),
                    const Divider(thickness: 1.0, height: 1.0),
                    ExpansionItemWidget(
                      title: 'businessman'.tr,
                      value: 'business',
                      groupValue: _contractorType,
                      onChanged: (value) {
                        setState(() => _contractorType = value);
                      },
                    ),
                    const Divider(thickness: 1.0, height: 1.0),
                    ExpansionItemWidget(
                      title: 'retired'.tr,
                      value: 'retirement',
                      groupValue: _contractorType,
                      onChanged: (value) {
                        setState(() => _contractorType = value);
                      },
                    ),
                    const Divider(thickness: 1.0, height: 1.0),
                    ExpansionItemWidget(
                      title: 'unemployed'.tr,
                      value: 'unEmployed',
                      groupValue: _contractorType,
                      onChanged: (value) {
                        setState(() => _contractorType = value);
                      },
                    ),
                    const Divider(thickness: 1.0, height: 1.0),
                    ExpansionItemWidget(
                      title: 'student'.tr,
                      value: 'student',
                      groupValue: _contractorType,
                      onChanged: (value) {
                        setState(() => _contractorType = value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
