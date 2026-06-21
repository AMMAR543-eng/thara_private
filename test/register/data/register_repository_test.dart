import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

// 🔥 Mock Remote
class MockRegisterRemoteDataSource extends Mock
    implements RegisterRemoteDataSourceRepo {}

void main() {
  late RegisterRepositoryImpl repository;
  late MockRegisterRemoteDataSource mockRemote;

  setUp(() {
    mockRemote = MockRegisterRemoteDataSource();
    repository = RegisterRepositoryImpl(mockRemote);
  });

  tearDown(() {
    reset(mockRemote);
  });

  final testData = {
    "email": "test@test.com",
    "password": "123456"
  };

  // ================================
  // ✅ REGISTER EMAIL SUCCESS
  // ================================
  test('should return Right(LoginEntity) when registerEmail succeeds',
          () async {
        final model = LoginResponseModel();

        when(() => mockRemote.registerEmail(testData))
            .thenAnswer((_) async => Success<LoginResponseModel>(model));

        final result = await repository.registerEmailDomain(testData);

        expect(result, isA<Right>());
        verify(() => mockRemote.registerEmail(testData)).called(1);
      });

  // ================================
  // ❌ REGISTER EMAIL FAILURE
  // ================================
  test('should return Left(AppError) when registerEmail fails', () async {
    final apiError = ApiErrorModel(message: "error");
    final failure = Failure<LoginResponseModel>(apiError);

    when(() => mockRemote.registerEmail(testData))
        .thenAnswer((_) async => failure);

    final result = await repository.registerEmailDomain(testData);

    expect(result, isA<Left>());

    result.fold(
          (l) => expect(l.messege, "error"),
          (_) => fail("Expected failure"),
    );
  });

  // ================================
  // ✅ VERIFY OTP SUCCESS
  // ================================
  test('should return Right(BaseEntity) when verifyOtp succeeds', () async {
    final model = OtpModel();

    when(() => mockRemote.verifyOtp("1234", url: null))
        .thenAnswer((_) async => Success<OtpModel>(model));

    final result = await repository.verifyOtpDomain("1234");

    expect(result, isA<Right>());
    verify(() => mockRemote.verifyOtp("1234", url: null)).called(1);
  });

  // ================================
  // ❌ VERIFY OTP FAILURE
  // ================================
  test('should return Left(AppError) when verifyOtp fails', () async {
    final apiError = ApiErrorModel(message: "error");
    final failure = Failure<OtpModel>(apiError);

    when(() => mockRemote.verifyOtp("1234", url: null))
        .thenAnswer((_) async => failure);

    final result = await repository.verifyOtpDomain("1234");

    expect(result, isA<Left>());
  });

  // ================================
  // ✅ RESEND OTP SUCCESS
  // ================================
  test('should return Right(BaseEntity) when resendOtp succeeds',
          () async {
        final model = OtpModel();

        when(() => mockRemote.resendOtp(testData, url: null))
            .thenAnswer((_) async => Success<OtpModel>(model));

        final result = await repository.resendOtpDomain(testData);

        expect(result, isA<Right>());
        verify(() => mockRemote.resendOtp(testData, url: null)).called(1);
      });

  // ================================
  // ❌ RESEND OTP FAILURE
  // ================================
  test('should return Left(AppError) when resendOtp fails', () async {
    final apiError = ApiErrorModel(message: "error");
    final failure = Failure<OtpModel>(apiError);

    when(() => mockRemote.resendOtp(testData, url: null))
        .thenAnswer((_) async => failure);

    final result = await repository.resendOtpDomain(testData);

    expect(result, isA<Left>());
  });
}