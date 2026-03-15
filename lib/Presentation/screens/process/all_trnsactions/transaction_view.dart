// import 'package:thara/Presentation/screens/process/all_trnsactions/widgets/bank_list_view_widget.dart';
// import 'package:thara/Presentation/screens/process/all_trnsactions/widgets/filter_widget.dart';
// import 'package:thara/Presentation/screens/process/all_trnsactions/widgets/tabs_transaction.dart';
// import 'package:thara/Presentation/screens/process/deposites_list_view_widget.dart';
// import 'package:thara/Presentation/screens/process/withdraw_list_view_widget.dart';
// import 'package:thara/Presentation/screens/process/shimmer/deposite_shimmer.dart';
//
// import '../../../../index/index_main.dart';
//
// class TransactionView extends StatefulWidget {
//   const TransactionView({super.key});
//
//   @override
//   State<TransactionView> createState() => _TransactionViewState();
// }
//
// class _TransactionViewState extends State<TransactionView> {
//   late final ProcessController processController;
//
//   @override
//   void initState() {
//     processController = initUseCase(() => ProcessController());
//     processController.tab_index = 0;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         title: Text("transactions".tr, style: context.typography.font70Black),
//       ),
//       body: GetBuilder<ProcessController>(
//         init: ProcessController(),
//         builder: (controller) {
//           return ListView(
//             children: [
//               TransactionTabsWidget(controller: controller),
//               FilterWidget(
//                 index: controller.tab_index,
//                 title: controller.tab_index == 0
//                     ? "deposit_log".tr
//                     : controller.tab_index == 1
//                     ? "withdraw_log".tr
//                     : "bank_log".tr,
//                 subtitle: "all_transactions_note".tr,
//                 onFilterTap: () => controller.showFilterBottomSheet(context),
//                 onAddTap: () {
//                   Get.toNamed(storeBankView);
//                 },
//               ),
//
//               controller.tab_index == 0
//                   ? controller.depositeDataEntity == null
//                         ? const TransactionListShimmerWidget()
//                         : DepositesListViewWidget(controller: controller)
//                   : controller.withdrawDataEntity == null
//                         ? const TransactionListShimmerWidget()
//                         : WithdrawListViewWidget(controller: controller)
//
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
