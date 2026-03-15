// import '../../../../../index/index_main.dart';
//
// class SingleOnboardingPage extends StatelessWidget {
//   final OnboardingItem item;
//   final bool lastIndex;
//   final void Function()? onPressed;
//
//   const SingleOnboardingPage({
//     super.key,
//     required this.item,
//     required this.lastIndex,
//     this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(30.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 6,
//             child: Image.asset(
//               item.image,
//               fit: BoxFit.contain,
//               height: 300.h,
//               width: 300.w,
//             ),
//           ),
//           // SizedBox(height: 10.getHeight()),
//           Expanded(
//             flex: 2,
//             child: Text(
//               item.description,
//               textAlign: TextAlign.center,
//               style: context.typography.font63Green.copyWith(
//                 color: AppColors.whiteSmoke,
//               ),
//             ),
//           ),
//           if (lastIndex) ...[
//             AuthButtonWidget(title: "سجل الآن".tr, onPressed: onPressed),
//           ] else ...[
//             Expanded(
//               flex: 1,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
//                 child: Container(),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
