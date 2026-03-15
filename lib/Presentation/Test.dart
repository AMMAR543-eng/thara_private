import 'package:moyasar/moyasar.dart';

import '../index/index_main.dart';

import 'package:moyasar/moyasar.dart';
import '../index/index_main.dart';

class Test extends StatelessWidget {
  final int? amount; // SAR

  const Test({super.key, this.amount});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController(amount ?? 0));
    final typography = context.typography;

    return Scaffold(
      backgroundColor: AppColors.background_neutral_surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background_neutral_surface,
        leading: BackButton(color: AppColors.primary),
        title: Text(
          "payment".tr,
          style: typography.bodyLarge.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Amount Summary
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.content_brand_secondary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "total_amount".tr,
                      style: typography.bodyMedium.copyWith(
                        color: AppColors.content_secondary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${amount ?? 0}",
                          style: typography.headerXLarge.copyWith(
                            color: AppColors.content_brand_secondary,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        SvgPicture.asset(
                          IconsConstants.riyal,
                          height: 30,
                          width: 30,
                          color: AppColors.content_primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              /// 🔹 Payment Content
              Expanded(
                child: Obx(() {
                  /// Loading
                  if (controller.isLoading.value) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        SizedBox(height: 12.h),
                        Text(
                          "preparing_payment".tr,
                          style: typography.bodyMedium,
                        ),
                      ],
                    );
                  }

                  /// Error
                  if (controller.walletReference == null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: AppColors.errorForeground,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "payment_init_failed".tr,
                            style: typography.bodyLarge.copyWith(
                              color: AppColors.errorForeground,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  /// Moyasar Card
                  return Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: CreditCard(
                      config: controller.paymentConfig,
                      onPaymentResult: controller.onPaymentResult,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentController extends GetxController {
  final int amount; // SAR
  PaymentController(this.amount);

  //static const _apiKey = 'pk_test_Vi4s6v1WgiJM3w2p8hqFkNsnpdpjfrbc7QNysDuT';
  static const _apiKey = 'pk_live_fSMqaRA66sKC99ezfPTdvpXnTX5nXxLdxjprT6Nh';

  final isLoading = false.obs;
  String? walletReference;

  late final PaymentModel payment;

  @override
  void onInit() {
    super.onInit();

    payment = PaymentModel(
      amount: amount * 100, // ✅ Moyasar uses smallest unit
      description: 'Wallet deposit',
    );

    _initWalletPayment();
  }

  Future<void> _initWalletPayment() async {
    isLoading.value = true;

    final response = await createWalletPayment(
      params: WalletPaymentParams(
        paymentAmount: amount.toDouble(), // backend expects SAR
        paymentType: "card",
      ),
    );

    walletReference = response?.reference;
    isLoading.value = false;
  }

  PaymentConfig get paymentConfig {
    if (walletReference == null || walletReference!.isEmpty) {
      throw StateError(
        'Wallet reference is null — paymentConfig accessed too early',
      );
    }

    return payment.toConfig(_apiKey, givenId: walletReference!);
  }

  void onPaymentResult(dynamic result) {
    if (result is PaymentResponse) {
      final paymentId = result.id;

      if (paymentId == null || paymentId.isEmpty) {
        debugPrint('❌ Payment ID is null');
        Get.snackbar(
          'Payment Error',
          'Payment ID not returned. Please try again.',
        );
        return;
      }

      switch (result.status) {
        case PaymentStatus.paid:
        case PaymentStatus.authorized:
        case PaymentStatus.captured:
          _sendPaymentIdToBackend(paymentId);
          break;

        case PaymentStatus.failed:
          Get.snackbar('Payment Failed', 'Your payment could not be completed');
          break;

        case PaymentStatus.initiated:
          break;
      }
    } else if (result is AuthError) {
      Get.snackbar('Payment Error', result.message ?? 'Authentication failed');
    }
  }

  Future<void> _sendPaymentIdToBackend(String paymentId) async {
    final result = await checkWalletPayment(paymentId: paymentId);
    print("data status is ${result?.status}");
    print("data status is ${result?.toJson()}");
    if (result?.status == "paid") {
      Get.offAll(() => MainPage(indexNum: 3), binding: Binding());
    }
    debugPrint("Payment status: ${result?.status}");
  }

  Future<CreatePaymentResponseModel?> createWalletPayment({
    required WalletPaymentParams params,
  }) async {
    final completer = Completer<CreatePaymentResponseModel?>();

    ProcessService().createWalletPayment(
      params: params,
      voidCallBack: completer.complete,
    );

    return completer.future;
  }

  Future<CheckPaymentResponseModel?> checkWalletPayment({
    required String paymentId,
  }) async {
    final completer = Completer<CheckPaymentResponseModel?>();

    ProcessService().checkWalletPayment(
      paymentId: paymentId,
      voidCallBack: completer.complete,
    );

    return completer.future;
  }
}

class PaymentModel {
  final int amount;
  final String description;

  const PaymentModel({required this.amount, required this.description});

  PaymentConfig toConfig(String apiKey, {required String givenId}) {
    return PaymentConfig(
      publishableApiKey: apiKey,
      amount: amount,
      description: description,
      givenID: givenId,
      creditCard: CreditCardConfig(saveCard: false, manual: false),
    );
  }
}
