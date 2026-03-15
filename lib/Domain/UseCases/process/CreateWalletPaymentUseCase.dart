// The UseCase class for creating wallet payment
import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class CreateWalletPaymentUseCase
    extends
        Use_Case<
          Either<AppError, CreatePaymentResponseModel>,
          WalletPaymentParams
        > {
  final ProcessRepository _processRepository;

  // Constructor
  CreateWalletPaymentUseCase(this._processRepository);

  @override
  Future<Either<AppError, CreatePaymentResponseModel>> call(
    WalletPaymentParams processParam,
  ) async {
    return await _processRepository.createWalletPaymentDomain(
      processParam.toJson(),
    );
  }
}

class WalletPaymentParams {
  final double? paymentAmount; // 🔹 قيمة الدفع
  final String? paymentType; // 🔹 نوع الدفع (card / wallet / ...)

  WalletPaymentParams({this.paymentAmount, this.paymentType});

  /// ✅ Convert to JSON (for API requests)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (paymentAmount != null) {
      data['payment_amount'] = paymentAmount;
    }

    if (paymentType != null && paymentType!.isNotEmpty) {
      data['payment_type'] = paymentType;
    }

    return data;
  }

  /// ✅ Create a modified copy
  WalletPaymentParams copyWith({double? paymentAmount, String? paymentType}) {
    return WalletPaymentParams(
      paymentAmount: paymentAmount ?? this.paymentAmount,
      paymentType: paymentType ?? this.paymentType,
    );
  }
}
