// import '../../../../index/index_main.dart';
//
// class OtpScreen extends StatefulWidget {
//   final String? title;
//   final String? desc;
//   final OtpPages? page;
//
//   const OtpScreen({super.key, this.title, this.desc, this.page});
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   late GenericKeyboardManager<String> keyboardManager;
//
//   final otpController = Get.find<OtpController>();
//   final formOtpKey = GlobalKey<FormState>();
//   final numberController = TextEditingController();
//
//   @override
//   void initState() {
//     keyboardManager = GenericKeyboardManager<String>(nodeCount: 1);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     keyboardManager.dispose();
//     numberController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF003B3A),
//       body: GetBuilder<OtpController>(
//         init: OtpController(),
//         builder: (controller) {
//           return KeyboardActions(
//             config: keyboardManager.buildConfig(),
//             child: CustomScrollView(
//               shrinkWrap: true,
//               slivers: [
//                 /// Header
//                 SliverToBoxAdapter(
//                   child: Container(
//                     height: MediaQuery.of(context).size.height * 0.3,
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [Color(0xFF003B3A), Colors.black],
//                       ),
//                     ),
//                     child: const Center(heightFactor: 4, child: LogoWidget()),
//                   ),
//                 ),
//
//                 /// Form
//                 SliverFillRemaining(
//                   hasScrollBody: false,
//                   child: Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withAlpha(128),
//                           blurRadius: 10,
//                           spreadRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child: Form(
//                       key: formOtpKey,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 20.w),
//                         child: Column(
//                           children: [
//                             SizedBox(height: 40.h),
//
//                             /// Title + Back Button
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Spacer(),
//                                 const Spacer(),
//                                 AuthTitleWidget(title: widget.title ?? ""),
//                                 const Spacer(),
//                                 const BackButtonWidget(),
//                               ],
//                             ),
//
//                             SizedBox(height: 60.h),
//
//                             /// Description
//                             AuthDescWidget(desc: widget.desc ?? ""),
//                             SizedBox(height: 40.h),
//
//                             /// OTP Input
//                             Directionality(
//                               textDirection: TextDirection.ltr,
//                               child: PinCodeTextField(
//                                 appContext: context,
//                                 controller: numberController,
//                                 length: widget.page == OtpPages.forget ? 6 : 4,
//                                 // 👈 Add this condition
//                                 obscureText: false,
//                                 onChanged: (value) {
//                                   controller.setOtpValidation(
//                                     value.length ==
//                                         (widget.page == OtpPages.forget
//                                             ? 6
//                                             : 4), // 👈 also update here
//                                   );
//                                 },
//                                 keyboardType: TextInputType.number,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 textStyle: const TextStyle(
//                                   color: AppColors.mediumJungleGreen,
//                                   fontSize: 26,
//                                 ),
//                                 pinTheme: PinTheme(
//                                   borderWidth: 0.5,
//                                   inactiveBorderWidth: 1,
//                                   shape: PinCodeFieldShape.box,
//                                   borderRadius: BorderRadius.circular(12),
//                                   fieldHeight: 100.h,
//                                   fieldWidth: 100.w,
//                                   activeFillColor: Colors.white,
//                                   inactiveColor: AppColors.darkGray,
//                                 ),
//                               ),
//                             ),
//
//                             SizedBox(height: 40.h),
//
//                             /// Resend Button
//                             Obx(
//                               () => TextButton(
//                                 onPressed: controller.enableResend.value
//                                     ? widget.page == OtpPages.register
//                                           ? controller.registerResendOtpApi
//                                           : controller.resendOtp
//                                     : null,
//                                 child: Text(
//                                   controller.enableResend.value
//                                       ? "أعد ارسال الرمز".tr
//                                       : 'أعد ارسال الرمز في ${controller.secondsRemaining.value} ثواني ',
//                                   style: context.typography.font52Grey.copyWith(
//                                     color: AppColors.darkGray,
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                             /// Submit Button
//                             const Spacer(),
//                             GetBuilder<OtpController>(
//                               id: 'otp_button',
//                               builder: (controller) {
//                                 return SafeArea(
//                                   child: AuthButtonWidget(
//                                     title: "التحقق من الرمز".tr,
//                                     onPressed: controller.validOtp
//                                         ? () {
//                                             final code = numberController.text;
//
//                                             void clearInput() {
//                                               FocusScope.of(context).unfocus();
//                                               numberController.clear();
//                                             }
//
//                                             if (widget.page ==
//                                                 OtpPages.forget) {
//                                               Get.toNamed(
//                                                 resetPasswordScreen,
//                                                 arguments: [
//                                                   {"code": code},
//                                                 ],
//                                               );
//                                               clearInput();
//                                             } else if (widget.page ==
//                                                 OtpPages.login) {
//                                               controller.verifyOtp(
//                                                 code,
//                                                 clearInput,
//                                               );
//                                             } else if (widget.page ==
//                                                 OtpPages.register) {
//                                               controller.registerVerifyOtp(
//                                                 code,
//                                                 clearInput,
//                                               );
//                                             }
//                                           }
//                                         : null,
//                                   ),
//                                 );
//                               },
//                             ),
//
//                             SizedBox(height: 60.h),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
