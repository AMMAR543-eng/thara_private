import 'package:hijri/hijri_calendar.dart';
import '../../../../../index/index_main.dart';

class RegisterInfoController extends GetxController {
  RxBool termsValue = false.obs;

  // Inputs
  final idController = TextEditingController();
  final dateController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();
  final commercialController = TextEditingController();
  final numberController = TextEditingController();

  RxBool acceptSignature = false.obs;
  RxBool acceptCredits = false.obs;

  // Validation flags
  bool validPhone = false;
  bool validId = false;
  bool validCompanyName = false;
  bool validCommercial = false;
  bool validUnified = false;
  String? completePhone;
  String? hijriEquivalent;

  /// Individual
  GenericListModel? selectedCitizenShip;
  List<GenericListModel>? listCitizenShip;

  /// Company
  GenericListModel? selectedCompanyType;
  List<GenericListModel>? listCompanyType = [
    GenericListModel(
      id: 1,
      name_ar: "الزراعة والحراجة وصيد الأسماك",
      name: "Agriculture",
    ),
    GenericListModel(
      id: 2,
      name_ar: "التعدين واستغلال المحاجر",
      name: "Mining and Quarrying",
    ),
    GenericListModel(
      id: 3,
      name_ar: "الصناعة التحويلية",
      name: "Manufacturing",
    ),
    GenericListModel(
      id: 4,
      name_ar: "إمدادات الكهرباء والغاز والبخار وتكييف الهواء",
      name: "Electricity",
    ),
    GenericListModel(
      id: 5,
      name_ar: "إمدادات المياه وأنشطة الصرف الصحي وإدارة النفايات ومعالجتها",
      name: "Water Supply",
    ),
    GenericListModel(id: 6, name_ar: "التشييد", name: "Construction"),
    GenericListModel(
      id: 7,
      name_ar:
          "تجارة الجملة والتجزئة، وإصلاح المركبات ذات المحركات والدراجات النارية",
      name: "Retail",
    ),
    GenericListModel(id: 8, name_ar: "النقل والتخزين", name: "Transportation"),
    GenericListModel(
      id: 9,
      name_ar: "أنشطة خدمات الإقامة والطعام",
      name: "Accommodation",
    ),
    GenericListModel(
      id: 10,
      name_ar: "المعلومات والاتصالات",
      name: "Communication",
    ),
    GenericListModel(
      id: 11,
      name_ar: "الأنشطة المالية وأنشطة التأمين",
      name: "Financial",
    ),
    GenericListModel(id: 12, name_ar: "الأنشطة العقارية", name: "Real Estate"),
    GenericListModel(
      id: 13,
      name_ar: "الأنشطة المهنية والعلمية والتقنية",
      name: "Technical",
    ),
    GenericListModel(
      id: 14,
      name_ar: "أنشطة الخدمات الإدارية وخدمات الدعم",
      name: "Administrative",
    ),
    GenericListModel(
      id: 15,
      name_ar: "الإدارة العامة والدفاع ، الضمان الاجتماعي الإلزامي",
      name: "Social Security",
    ),
    GenericListModel(id: 16, name_ar: "التعليم", name: "Education"),
    GenericListModel(
      id: 17,
      name_ar: "الأنشطة في مجال صحة الإنسان والعمل الاجتماعي",
      name: "Human Health",
    ),
    GenericListModel(id: 18, name_ar: "الفنون والترفيه والتسلية", name: "Arts"),
    GenericListModel(
      id: 19,
      name_ar: "أنشطة الأُسر المعيشية",
      name: "Households",
    ),
    GenericListModel(
      id: 20,
      name_ar: "أنشطة المنظمات والهيئات غير الخاضعة للولاية القضائية الوطنية",
      name: "Extraterritorial",
    ),
    GenericListModel(id: 21, name_ar: "أنشطة الخدمات الأخرى", name: "Other"),
  ];

  // Actions
  void onCitizenShipSelected(GenericListModel? citizenShip) {
    selectedCitizenShip = citizenShip;
    update();
  }

  void onCompanyTypeSelected(GenericListModel? companyType) {
    selectedCompanyType = companyType;
    update();
  }

  void acceptSignatureAction() {
    acceptSignature.value = !acceptSignature.value;
    update();
  }

  void acceptCreditsAction() {
    acceptCredits.value = !acceptCredits.value;
    update();
  }

  void setValidation({
    bool? phone,
    bool? id,
    bool? companyName,
    bool? commercial,
    bool? unified,
  }) {
    if (phone != null) validPhone = phone;
    if (id != null) validId = id;
    if (companyName != null) validCompanyName = companyName;
    if (commercial != null) validCommercial = commercial;
    if (unified != null) validUnified = unified;
    update();
  }

  // Validation
  bool isValidIndividual() {
    return validPhone &&
        validId &&
        dateController.text.isNotEmpty &&
        acceptSignature.value &&
        selectedCitizenShip != null;
  }

  bool isValidCompany() {
    return validPhone &&
        validId &&
        validCompanyName &&
        validCommercial &&
        validUnified &&
        dateController.text.isNotEmpty &&
        acceptSignature.value &&
        acceptCredits.value &&
        selectedCitizenShip != null &&
        selectedCompanyType != null;
  }

  // API
  @override
  void onInit() {
    getCitizenShipsApi();
    super.onInit();
  }

  getCitizenShipsApi() {
    RegisterService().getCitizenShips(
      voidCallBack: (data) {
        listCitizenShip = data.citizenShips?.map((item) {
          var index = data.citizenShips?.indexOf(item);
          return GenericListModel(
            id: index!,
            name: item.name,
            name_ar: item.name,
            text: item.isoCode,
          );
        }).toList();

        /// ✅ Set default to "المملكة العربية السعودية"
        selectedCitizenShip = listCitizenShip?.firstWhere(
          (item) =>
              item.name_ar == "المملكة العربية السعودية" ||
              item.name == "Saudi Arabia",
          orElse: () => listCitizenShip!.first,
        );

        update();
      },
    );
  }

  String handleGregorianDateSelected(String gregorianDateStr) {
    final dateParts = gregorianDateStr.split('-');
    final year = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1]);
    final day = int.parse(dateParts[2]);

    final selectedGregorian = DateTime(year, month, day);
    final hijri = HijriCalendar.fromDate(selectedGregorian);

    final formattedHijri =
        "${hijri.hYear}-${hijri.hMonth.toString().padLeft(2, '0')}-${hijri.hDay.toString().padLeft(2, '0')}";

    hijriEquivalent = formattedHijri;
    update();
    return formattedHijri;
  }

  bool isHijriDate(String dateStr) {
    final parts = dateStr.split('-');
    if (parts.length != 3) return false;
    final year = int.tryParse(parts[0]);
    if (year == null) return false;
    return year < 1600;
  }

  void submit({
    required bool isCompany,
    required GlobalKey<FormState> formKey,
  }) {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final String dob = isHijriDate(dateController.text) == true
        ? dateController.text
        : hijriEquivalent ?? "";

    final String citizenship = selectedCitizenShip?.text ?? '';
    final String phoneNumber = completePhone ?? '';
    final String nin = idController.text;

    if (isCompany) {
      final companyParam = CompanyParam(
        name: companyController.text,
        fieldOfBusiness: selectedCompanyType?.name ?? '',
        crn: commercialController.text,
        unifiedNumber: numberController.text,
        citizenship: citizenship,
        phoneNumber: phoneNumber,
        nin: nin,
        dob: dob,
      );

      addCompanyApi(param: companyParam);
    } else {
      final individualParam = IndividualParam(
        citizenship: citizenship,
        phoneNumber: phoneNumber,
        nin: nin,
        dob: dob,
      );

      addIndividualApi(individualParam);
    }
  }

  addIndividualApi(IndividualParam param) {
    RegisterService().addIndividual(
      param: param,
      voidCallBack: (data) {
        if (data.customStatusCode == 200) {
          handleUserNavigation(
            account: data.account ?? const AccountModel(),
            user: data.user ?? UserEntity(),
          );
        }
      },
    );
  }

  addCompanyApi({required CompanyParam param}) {
    RegisterService().addCompany(
      param: param,
      voidCallBack: (data) {
        if (data.customStatusCode == 200) {
          handleUserNavigation(
            account: data.account ?? const AccountModel(),
            user: data.user ?? UserEntity(),
          );
        }
      },
    );
  }
}
