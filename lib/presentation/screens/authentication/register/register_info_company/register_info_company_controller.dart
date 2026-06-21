import '../../../../../index/index_main.dart';

class RegisterCompanyInfoController extends GetxController {
  final unifiedController = TextEditingController();
  final expiryController = TextEditingController();

  bool isFormValid = false;

  CompanyInfoModel? companyInfo;

  void checkIfReady() {
    if (unifiedController.text.isNotEmpty && expiryController.text.isNotEmpty) {
      // simulate API call to fetch company data
      fetchCompanyInfo();
    }
  }

  void fetchCompanyInfo() {
    // TODO: Replace with real API
    companyInfo = CompanyInfoModel(
      name: "الوسمة للأغذية",
      activity: "الأغذية والمشروبات",
      city: "الرياض",
      district: "الملقا",
      buildingNo: "5788",
      street: "145",
    );
    isFormValid = true;
    update();
  }

  void submit(GlobalKey<FormState> formKey) {
    if (!(formKey.currentState?.validate() ?? false)) return;
    // Continue to next step
  }
}

class CompanyInfoModel {
  final String name;
  final String activity;
  final String city;
  final String district;
  final String buildingNo;
  final String street;

  CompanyInfoModel({
    required this.name,
    required this.activity,
    required this.city,
    required this.district,
    required this.buildingNo,
    required this.street,
  });
}
