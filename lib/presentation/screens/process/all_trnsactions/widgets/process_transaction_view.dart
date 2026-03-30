// import 'package:thara/Presentation/screens/process/all_trnsactions/transaction_view.dart';
// import 'package:thara/Presentation/screens/process/deposites_list_view_widget.dart';
//
// import '../../../../../../index/index_main.dart';
// import '../../shimmer/deposite_shimmer.dart';
//
// class PreviousTransactionsWidget extends StatelessWidget {
//   final ProcessController controller;
//
//   const PreviousTransactionsWidget({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("previous_transactions".tr, style: context.typography.font70Black),
//               InkWell(
//                 onTap: () {
//                   Get.to(
//                     () =>  const TransactionView(),
//                     binding: Binding(),
//                     duration: const Duration(milliseconds: 0),
//                   );
//                 },
//                 child: Text(
//                   "show_all".tr,
//                   style: context.typography.font37DarkGrey.copyWith(
//                     color: AppColors.textSecondaryParagraph,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         controller.depositeDataEntity == null
//             ? const TransactionListShimmerWidget()
//             : DepositesListViewWidget(controller: controller),
//       ],
//     );
//   }
// }
