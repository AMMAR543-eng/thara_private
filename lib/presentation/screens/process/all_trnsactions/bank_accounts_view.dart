
import '../../../../index/index_main.dart';

class BankAccountsView extends StatefulWidget {
  const BankAccountsView({super.key});

  @override
  State<BankAccountsView> createState() => _BankAccountsViewState();
}

class _BankAccountsViewState extends State<BankAccountsView> {
  late final ProcessController processController;

  @override
  void initState() {
    processController = initUseCase(() => ProcessController());
    processController.tab_index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          "الحسابات البنكية".tr,
          style: context.typography.font70Black,
        ),
      ),
      body: GetBuilder<ProcessController>(
        init: ProcessController(),
        builder: (controller) {
          return ListView(
            children: [
              FilterWidget(
                index: 2,
                title: "bank_log".tr,
                subtitle: "all_transactions_note".tr,
                onFilterTap: () => controller.showFilterBottomSheet(context),
                onAddTap: () {
                  Get.toNamed(storeBankView);
                },
              ),

              controller.bankAccountDataEntity == null
                  ? const TransactionListShimmerWidget()
                  : BankListViewWidget(controller: controller),
            ],
          );
        },
      ),
    );
  }
}
