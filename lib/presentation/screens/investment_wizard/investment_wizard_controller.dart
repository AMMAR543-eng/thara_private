// investment_wizard_controller.dart
import 'package:thara/index/index_main.dart';

class InvestmentWizardController extends GetxController {
  // current step index
  int currentStep = 0;

  // Data model
  InvestmentWizardEntity data = InvestmentWizardEntity(
    opportunities: [],
    amount: InvestmentAmount(min: null, max: null),
    packages: [],
    durations: [],
  );

  // Text controllers
  final minController = TextEditingController();
  final maxController = TextEditingController();

  // Flags
  bool isLoading = false;
  bool isEditMode = false;
  String? serverMessage;

  final OpportunitiesService _service = OpportunitiesService();

  List<OpportunityType> defaultOpportunities = [
    OpportunityType(
      id: 1,
      name: "real_estate_title".tr,
      icon: "icons/real_estate.svg",
      apiKey: "real_state",
    ),
    OpportunityType(
      id: 2,
      name: "invoice_title".tr,
      icon: "icons/invoice.svg",
      apiKey: "invoice",
    ),
  ];

  List<PackageEntity> defaultPackages = [
    PackageEntity(id: 1, title: "A-AA", description: "package_a_desc".tr),
    PackageEntity(id: 2, title: "B-BB", description: "package_b_desc".tr),
    PackageEntity(id: 3, title: "C-CC", description: "package_c_desc".tr),
  ];

  // ────────────────────────────────────────────────────────────────
  // INIT
  // ────────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();

    // opportunities
    data.opportunities = defaultOpportunities
        .map(
          (e) => OpportunityType(
            id: e.id,
            name: e.name,
            icon: e.icon,
            apiKey: e.apiKey,
          ),
        )
        .toList();

    if (data.opportunities!.isNotEmpty) {
      // data.opportunities![0].selected = true;
    }

    // packages
    data.packages = defaultPackages
        .map(
          (e) => PackageEntity(
            id: e.id,
            title: e.title,
            description: e.description,
            selected: false,
          ),
        )
        .toList();

    if (data.packages!.isNotEmpty) {
      //  data.packages![0].selected = true;
    }
  }

  // ────────────────────────────────────────────────────────────────
  // MULTI-SELECT: Duration
  // ────────────────────────────────────────────────────────────────
  void toggleDuration(int id) {
    final index = data.durations?.indexWhere((d) => d.id == id);
    if (index != null && index >= 0) {
      data.durations![index].selected = !data.durations![index].selected;
      update();
    }
  }

  // ────────────────────────────────────────────────────────────────
  // LOAD FOR EDIT MODE (PRE-FILL UI)
  // ────────────────────────────────────────────────────────────────
  void loadForEdit(InvestmentWizardEntity existing) {
    isEditMode = true;

    // opportunities
    for (final opp in data.opportunities!) {
      opp.selected =
          existing.opportunities?.any((e) => e.apiKey == opp.apiKey) ?? false;
    }

    // amount
    data.amount = existing.amount ?? InvestmentAmount();
    minController.text = data.amount?.min ?? "";
    maxController.text = data.amount?.max ?? "";

    // packages
    for (final p in data.packages!) {
      p.selected = existing.packages?.any((e) => e.title == p.title) ?? false;
    }

    // durations
    for (final dur in data.durations!) {
      dur.selected =
          existing.durations?.any((e) => e.apiValue == dur.apiValue) ?? false;
    }

    update();
  }

  // ────────────────────────────────────────────────────────────────
  // STEP VALIDATION (for bottom button)
  // ────────────────────────────────────────────────────────────────
  bool isStepValid(int step) {
    switch (step) {
      case 0:
        return data.opportunities!.any((e) => e.selected);

      case 1:
        final min = int.tryParse(minController.text.trim());
        final max = int.tryParse(maxController.text.trim());
        if (min == null || min <= 0) return false;
        if (max == null || max <= 0) return false;
        if (max < min) return false;
        if (max % 1000 != 0) return false;
        return true;

      case 2:
        return data.packages!.any((p) => p.selected);

      case 3:
        return data.durations!.any((d) => d.selected);

      default:
        return false;
    }
  }

  // ────────────────────────────────────────────────────────────────
  // NAVIGATION
  // ────────────────────────────────────────────────────────────────
  void nextStep() {
    if (!validateStep(currentStep)) return;
    if (currentStep < 3) {
      currentStep++;
      update();
    }
  }

  void prevStep() {
    if (currentStep > 0) {
      currentStep--;
      update();
    }
  }

  void goToStep(int index) {
    currentStep = index.clamp(0, 4);
    update();
  }

  // ────────────────────────────────────────────────────────────────
  // VALIDATE STEP WHEN MOVING NEXT
  // ────────────────────────────────────────────────────────────────
  bool validateStep(int step) {
    switch (step) {
      case 0:
        if (!data.opportunities!.any((e) => e.selected)) {
          serverMessage = "error_select_opportunity".tr;
          update();
          return false;
        }
        return true;

      case 1:
        final min = int.tryParse(minController.text) ?? 0;
        final max = int.tryParse(maxController.text) ?? 0;

        if (min <= 0) {
          serverMessage = "error_min_greater_zero".tr;
          update();
          return false;
        }
        if (max <= 0) {
          serverMessage = "error_max_greater_zero".tr;
          update();
          return false;
        }
        if (max < min) {
          serverMessage = "error_max_less_min".tr;
          update();
          return false;
        }
        if (max % 1000 != 0) {
          serverMessage = "error_amount_must_1000".tr;
          update();
          return false;
        }

        data.amount = InvestmentAmount(
          min: minController.text.trim(),
          max: maxController.text.trim(),
        );
        serverMessage = null;
        return true;

      case 2:
        if (!data.packages!.any((p) => p.selected)) {
          serverMessage = "error_select_package".tr;
          update();
          return false;
        }
        return true;

      default:
        return true;
    }
  }

  void toggleOpportunity(int id) {
    final index = data.opportunities?.indexWhere((e) => e.id == id);
    if (index != null && index >= 0) {
      data.opportunities![index].selected =
          !data.opportunities![index].selected;
      update();
    }
  }

  void togglePackage(int id) {
    final index = data.packages?.indexWhere((p) => p.id == id);
    if (index != null && index >= 0) {
      data.packages![index].selected = !data.packages![index].selected;
      update();
    }
  }

  // ────────────────────────────────────────────────────────────────
  // FINAL SUBMIT → SEND TO BACKEND
  // ────────────────────────────────────────────────────────────────
  Future<void> submit() async {
    // Validate all steps
    for (int s = 0; s <= 3; s++) {
      if (!validateStep(s)) {
        goToStep(s);
        return;
      }
    }

    isLoading = true;
    update();

    final payload = {
      "types": data.opportunities
          ?.where((e) => e.selected)
          .map((e) => e.apiKey)
          .toList(),
      "minAmount": int.parse(data.amount?.min ?? "0"),
      "maxAmount": int.parse(data.amount?.max ?? "0"),
      "creditRatings":
          data.packages?.where((p) => p.selected).map((p) => p.title).toList(),
      "durations": data.durations
          ?.where((d) => d.selected)
          .map((d) => d.apiValue) // "6", "12", "18"
          .toList(),
    };

    try {
      await _service.postAutoInvestment(
        payload: payload,
        voidCallBack: (success) {
          serverMessage = isEditMode ? "success_edit".tr : "success_create".tr;
          currentStep = 3;
          isLoading = false;
          DashboardController controller = initUseCase(
            () => DashboardController(),
          );
          controller.getAutoInvestData();
          controller.update();
          update();
        },
      );
    } catch (e) {
      isLoading = false;
      serverMessage = "error_general".tr;
      update();
    }
  }

  @override
  void onClose() {
    minController.dispose();
    maxController.dispose();
    super.onClose();
  }
}
