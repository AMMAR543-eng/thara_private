import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

// 🔥 Mock Repo
class MockProcessRepository extends Mock implements ProcessRepository {}

void main() {
  late CreateWalletPaymentUseCase createUseCase;
  late CheckWalletPaymentUseCase checkUseCase;
  late MockProcessRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(
      WalletPaymentParams(paymentAmount: 0, paymentType: ""),
    );
  });

  setUp(() {
    mockRepo = MockProcessRepository();
    createUseCase = CreateWalletPaymentUseCase(mockRepo);
    checkUseCase = CheckWalletPaymentUseCase(mockRepo);
  });

  final params = WalletPaymentParams(
    paymentAmount: 100,
    paymentType: "wallet",
  );

  // ================================
  // ✅ CREATE PAYMENT SUCCESS
  // ================================
  test('should return success when create payment succeeds', () async {
    final model = CreatePaymentResponseModel(reference: 'ref123');

    when(() => mockRepo.createWalletPaymentDomain(any()))
        .thenAnswer((_) async => Right(model));

    final result = await createUseCase(params);

    expect(result, Right(model));

    // 🔥 تحقق من القيم الصح
    verify(() => mockRepo.createWalletPaymentDomain(
      params.toJson(),
    )).called(1);
  });

  // ================================
  // ❌ CREATE PAYMENT FAILURE
  // ================================
  test('should return failure when create payment fails', () async {
    final error = AppError("error");

    when(() => mockRepo.createWalletPaymentDomain(any()))
        .thenAnswer((_) async => Left(error));

    final result = await createUseCase(params);

    expect(result, isA<Left>());
  });

  // ================================
  // ✅ CHECK PAYMENT SUCCESS
  // ================================
  test('should return success when check payment succeeds', () async {
    final model = CheckPaymentResponseModel(
      status: 'paid',
      isPaid: true,
    );

    when(() => mockRepo.checkWalletPaymentDomain(any()))
        .thenAnswer((_) async => Right(model));

    final result = await checkUseCase("123");

    expect(result, Right(model));
    verify(() => mockRepo.checkWalletPaymentDomain("123")).called(1);
  });
}