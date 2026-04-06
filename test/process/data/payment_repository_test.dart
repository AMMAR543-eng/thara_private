import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

// 🔥 Mock Remote
class MockProcessRemoteDataSource extends Mock
    implements ProcessRemoteDataSourceRepo {}

void main() {
  late ProcessRepositoryImpl repository;
  late MockProcessRemoteDataSource mockRemote;

  setUp(() {
    mockRemote = MockProcessRemoteDataSource();
    repository = ProcessRepositoryImpl(mockRemote);
  });

  final testData = {"amount": 100, "type": "wallet"};

  // ================================
  // ✅ CREATE PAYMENT SUCCESS
  // ================================
  test('should return Right when createWalletPayment succeeds', () async {
    final model = CreatePaymentResponseModel(reference: '');

    when(() => mockRemote.createWalletPayment(testData))
        .thenAnswer((_) async => Success(model));

    final result = await repository.createWalletPaymentDomain(testData);

    expect(result, Right(model));
    verify(() => mockRemote.createWalletPayment(testData)).called(1);
    verifyNoMoreInteractions(mockRemote);
  });

  // ================================
  // ❌ CREATE PAYMENT FAILURE
  // ================================
  test('should return Left when createWalletPayment fails', () async {
    final apiError = ApiErrorModel(message: "error");
    final failure = Failure<CreatePaymentResponseModel>(apiError);

    when(() => mockRemote.createWalletPayment(testData))
        .thenAnswer((_) async => failure);

    final result = await repository.createWalletPaymentDomain(testData);

    expect(result, isA<Left>());

    result.fold(
          (l) => expect(l.messege, "error"),
          (_) => fail("Expected failure"),
    );
  });

  // ================================
  // ✅ CHECK PAYMENT SUCCESS
  // ================================
  test('should return Right when checkWalletPayment succeeds', () async {
    const paymentId = "123";
    final model = CheckPaymentResponseModel(
      status: 'paid',
      isPaid: true,
    );
    when(() => mockRemote.checkWalletPayment({}, paymentId))
        .thenAnswer((_) async => Success(model));

    final result =
    await repository.checkWalletPaymentDomain(paymentId);

    expect(result, Right(model));
    verify(() => mockRemote.checkWalletPayment({}, paymentId)).called(1);
  });

  // ================================
  // ❌ CHECK PAYMENT FAILURE
  // ================================
  test('should return Left when checkWalletPayment fails', () async {
    const paymentId = "123";

    final apiError = ApiErrorModel(message: "error");
    final failure = Failure<CheckPaymentResponseModel>(apiError);

    when(() => mockRemote.checkWalletPayment({}, paymentId))
        .thenAnswer((_) async => failure);

    final result =
    await repository.checkWalletPaymentDomain(paymentId);

    expect(result, isA<Left>());
  });
}