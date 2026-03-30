import '../../../../../index/index_main.dart';

class StoreBankController extends GetxController {
  final TextEditingController aliasController = TextEditingController();
  final TextEditingController ibanController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final RxBool useAccountNumber = false.obs;

  String? filePath;
  GenericListModel? selectedBank;
  AddressEntity? selectedAddress;

  List<GenericListModel>? listBanks;
  List<AddressEntity>? listAddresses;
  bool isButtonEnabled = false;
  bool? isleanEnable = false;

  @override
  void onInit() {
    super.onInit();
    getBankAddresses();

    aliasController.addListener(validateForm);
    ibanController.addListener(validateForm);
    accountNumberController.addListener(validateForm);
  }

  void clearForm() {
    aliasController.clear();
    ibanController.clear();
    accountNumberController.clear();
    selectedBank = null;
    selectedAddress = null;
    filePath = null;
    isButtonEnabled = false;
    useAccountNumber.value = false;
    isleanEnable = false;
    update(); // Rebuilds UI
  }

  void getBankAddresses() {
    ProcessService().getBankAddresses(
      voidCallBack: (data) {
        listBanks = data.banks;
        isleanEnable = data.leanEnabled;
        //   isleanEnable = false;
        listAddresses = data.addresses;
        selectedAddress = data.addresses?.firstWhereOrNull(
          (e) => e.isPrimary == true,
        );
        update();
      },
    );
  }

  void validateForm() {
    isButtonEnabled = isleanEnable == true
        ? aliasController.text.isNotEmpty &&
              ibanController.text.isNotEmpty &&
              accountNumberController.text.isNotEmpty &&
              selectedAddress != null
        : aliasController.text.isNotEmpty &&
              ibanController.text.isNotEmpty &&
              accountNumberController.text.isNotEmpty &&
              selectedBank != null &&
              selectedAddress != null &&
              filePath != null;
    update();
  }

  void onPickFile(String? path) {
    filePath = path;
    validateForm();
  }

  void onRemoveFile() {
    filePath = null;
    validateForm();
  }

  void onBankSelected(GenericListModel? bank) {
    selectedBank = bank;
    validateForm();
  }

  void onAddressSelected(AddressEntity? address) {
    selectedAddress = address;
    validateForm();
  }

  void submitData() {
    if (!isButtonEnabled) return;

    final param = StoreBankParams(
      usedMethod: "MANUAL",
      iban: ibanController.text,
      accountNumber: accountNumberController.text,
      alias: aliasController.text,
      beneficiaryAddress1: selectedAddress?.city ?? "",
      beneficiaryAddress2: selectedAddress?.district ?? "",
      bankId: selectedBank?.id ?? 0,
      ibanCertificatePath: filePath ?? "",
    );

    final Map<String, dynamic> fields = param.toJson();
    final Map<String, String> files = param.toFiles();

    ProcessService().storeBank(
      params: CreateBankParams(params: fields, files: files),
      voidCallBack: (result) {
        WalletController walletController = initUseCase(
          () => WalletController(),
        );
        walletController.getBankAccounts();
        Get.back();
        Loader.showSuccess(result.message ?? "");
      },
    );
  }

  void submitDataWithLean() {
    if (!isButtonEnabled) return;

    final param = StoreBankWithLeanParams(
      usedMethod: "LEAN",
      iban: ibanController.text,
      accountNumber: accountNumberController.text,
      alias: aliasController.text,
      beneficiaryAddress1: selectedAddress?.city ?? "",
      beneficiaryAddress2: selectedAddress?.district ?? "",
    );

    ProcessService().storeBankWithLean(
      params: param,
      voidCallBack: (result) {
        WalletController walletController = initUseCase(
          () => WalletController(),
        );
        walletController.getBankAccounts();
        Get.back();
        Loader.showSuccess(result.message ?? "");
      },
    );
  }

  @override
  void dispose() {
    aliasController.dispose();
    ibanController.dispose();
    accountNumberController.dispose();
    super.dispose();
  }
}
