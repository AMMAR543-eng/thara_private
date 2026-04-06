import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

// Mock UseCases
class MockVerifyOtpUseCase extends Mock
    implements VerifyOtpDomainUseCase {}

class MockResendOtpUseCase extends Mock
    implements ResendOtpDomainUseCase {}

void main() {
  late AuthService service;
  late MockVerifyOtpUseCase mockVerify;
  late MockResendOtpUseCase mockResend;

  setUpAll(() {
    registerFallbackValue(OtpParams(code: ""));
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockVerify = MockVerifyOtpUseCase();
    mockResend = MockResendOtpUseCase();

    service = AuthService(
      verifyOtpUseCase: mockVerify,
      resendOtpUseCase: mockResend,
    );
  });

  // ================================
  // ✅ VERIFY OTP SUCCESS
  // ================================
  test('should call callback when verifyOtp succeeds', () async {
    final model = OtpModel();

    when(() => mockVerify.call(any()))
        .thenAnswer((_) async => Right(model));

    bool called = false;

    await service.verifyOtp(
      code: "1234",
      voidCallBack: (_) {
        called = true;
      },
    );

    expect(called, true);
    verify(() => mockVerify.call(any())).called(1);
    verifyNoMoreInteractions(mockVerify);
  });

  // ================================
  // ❌ VERIFY OTP FAILURE
  // ================================
  test('should NOT call callback when verifyOtp fails', () async {
    final error = AppError("error");

    when(() => mockVerify.call(any()))
        .thenAnswer((_) async => Left(error));

    bool called = false;

    await service.verifyOtp(
      code: "1234",
      voidCallBack: (_) {
        called = true;
      },
    );

    expect(called, false);
    verify(() => mockVerify.call(any())).called(1);
  });

  // ================================
  // ✅ RESEND OTP SUCCESS
  // ================================
  test('should call callback when resendOtp succeeds', () async {
    final model = OtpModel();

    when(() => mockResend.call(any()))
        .thenAnswer((_) async => Right(model));

    bool called = false;

    await service.resendOtp(
      voidCallBack: (_) {
        called = true;
      },
    );

    expect(called, true);
    verify(() => mockResend.call(any())).called(1);
    verifyNoMoreInteractions(mockResend);
  });

  // ================================
  // ❌ RESEND OTP FAILURE
  // ================================
  test('should NOT call callback when resendOtp fails', () async {
    final error = AppError("error");

    when(() => mockResend.call(any()))
        .thenAnswer((_) async => Left(error));

    bool called = false;

    await service.resendOtp(
      voidCallBack: (_) {
        called = true;
      },
    );

    expect(called, false);
    verify(() => mockResend.call(any())).called(1);
  });
}