// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../Global/index.dart';
// import 'package:testahelnew/Presentation/Widgets/CustomButton.dart';
// import 'package:testahelnew/Presentation/Widgets/TextWidget.dart';
//
// class UpdateWidget extends StatefulWidget {
//   Function? onpress;
//
//   UpdateWidget({Key? key, this.onpress}) : super(key: key);
//
//   @override
//   State<UpdateWidget> createState() => _UpdateWidgetState();
// }
//
// class _UpdateWidgetState extends State<UpdateWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(0, 0, 0, 0.001),
//       body: Container(
//         color: const Color.fromRGBO(0, 0, 0, 0.001),
//         child: DraggableScrollableSheet(
//           initialChildSize: 0.6,
//           minChildSize: 0.3,
//           maxChildSize: 0.8,
//           builder: (_, controller) {
//             return Container(
//               margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 180.h),
//               padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
//               decoration: BoxDecoration(
//                 color: ColorResources().COLOR_white,
//                 borderRadius: BorderRadius.circular(40.r),
//               ),
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                      TextWidget(
//                       title: "Update App",
//                       color: ColorResources().COLOR_BLACK,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 17,
//                     ),
//                      TextWidget(
//                       title:
//                           "You need to go to store to update testahel to be able to continue using the app",
//                       color: ColorResources().COLOR_GREY70,
//                       fontWeight: FontWeight.w500,
//                       textAlign: TextAlign.center,
//                       fontSize: 17,
//                     ),
//                     CustomButton(
//                       titleValue: "Go to Store",
//                       background: ColorResources().COLOR_Primary,
//                       widthValue: 300.w,
//                       fontSize: 17,
//                       onPress: () {
//                         Navigator.pop(context);
//                       },
//                       textColor: ColorResources().COLOR_white,
//                       roundValue: 15.r,
//                       containerHeight: 50.h,
//                     )
//                   ]),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
