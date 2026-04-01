import '../../../../../index/index_main.dart';

class StoreBankView extends StatefulWidget {
  const StoreBankView({Key? key}) : super(key: key);

  @override
  State<StoreBankView> createState() => _StoreBankViewState();
}

class _StoreBankViewState extends State<StoreBankView> {
  final HandleKeyboardService keyboardService = HandleKeyboardService();
  late final StoreBankController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(StoreBankController(), permanent: false);
    controller.clearForm(); // ✅ Clear everything when opened
    controller.getBankAddresses(); // ✅ Fetch fresh bank + address data
  }

  @override
  Widget build(BuildContext context) {
    final keys = keyboardService.generateKeys('StoreBankView', 3);

    return GetBuilder<StoreBankController>(
      init: StoreBankController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            title: Text(
              "add_bank_account".tr,
              style: context.typography.font55GreyLeft.copyWith(
                color: AppColors.background_black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: SizedBox(
              height: 100,
              child: Column(
                children: [
                  const Divider(),
                  BottomNavigationConfirm(controller: controller),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: Form(
              child: KeyboardActions(
                config: keyboardService.buildConfig(context, keys),
                child: controller.listBanks == null
                    ? const SizedBox()
                    : ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          const SizedBox(height: 8),

                          /// 🔹 Account Name (Alias)
                          CustomInputField(
                            label: "account_name".tr,
                            hintText: "account_name_hint".tr,
                            controller: controller.aliasController,
                            focusNode: keyboardService.getFocusNode(keys[0]),
                            show_asterisc: true,
                            padding_horizontal: 0,
                            keyboardType: TextInputType.name,
                            validator: InputValidators.combine([]),
                          ),
                          const SizedBox(height: 16),

                          /// 🔹 IBAN
                          CustomInputField(
                            label: "iban".tr,
                            hintText: "iban_hint".tr,
                            controller: controller.ibanController,
                            focusNode: keyboardService.getFocusNode(keys[1]),
                            show_asterisc: true,
                            padding_horizontal: 0,
                            keyboardType: TextInputType.name,
                            validator: InputValidators.combine([
                              notEmptyValidator,
                              InputValidators.validateSaudiIban,
                            ]),
                          ),
                          const SizedBox(height: 16),

                          /// 🔹 Account Number
                          CustomInputField(
                            label: "account_number".tr,
                            hintText: "account_number_hint".tr,
                            controller: controller.accountNumberController,
                            focusNode: keyboardService.getFocusNode(keys[2]),
                            keyboardType: TextInputType.number,
                            show_asterisc: true,
                            padding_horizontal: 0,
                            validator: InputValidators.combine([
                              notEmptyValidator,
                              InputValidators.validateBankAccountNumber,
                            ]),
                          ),
                          controller.isleanEnable == true
                              ? const SizedBox()
                              : const SizedBox(height: 16),

                          /// 🔹 Bank Dropdown
                          controller.isleanEnable == true
                              ? const SizedBox()
                              : GenericDropdown<GenericListModel>(
                                  hint_text: "bank".tr,
                                  title: "bank".tr,
                                  items: controller.listBanks ?? [],
                                  initialValue: controller.selectedBank,
                                  onChanged: controller.onBankSelected,
                                  displayItemBuilder: (item) => Text(
                                    item.name ?? "",
                                    style:
                                        context.typography.font33Grey.copyWith(
                                      color: ColorMappingImpl().textLabel,
                                    ),
                                  ),
                                ),
                          controller.isleanEnable == true
                              ? const SizedBox()
                              : const SizedBox(height: 16),

                          /// 📎 IBAN Certificate Upload
                          controller.isleanEnable == true
                              ? const SizedBox()
                              : FileUploadField(
                                  labelText: "iban_certificate".tr,
                                  filePath: controller.filePath,
                                  onPickFile: () async {
                                    String? filePath = await pickImage();
                                    controller.onPickFile(filePath);
                                  },
                                  onRemoveFile: controller.onRemoveFile,
                                ),
                          const SizedBox(height: 24),

                          /// 🔹 Payment Address List
                          if (controller.listAddresses != null &&
                              controller.listAddresses!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "payment_address".tr,
                                  style: context.typography.font55GreyLeft
                                      .copyWith(
                                    color: AppColors.background_black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ListView.builder(
                                  itemCount: controller.listAddresses!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final address =
                                        controller.listAddresses![index];
                                    return AddressItemWidget(
                                      address: address,
                                      isSelected:
                                          address == controller.selectedAddress,
                                      onTap: () {
                                        controller.onAddressSelected(address);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          const SizedBox(height: 16),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
