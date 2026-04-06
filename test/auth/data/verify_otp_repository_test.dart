import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

// Mock
class MockAuthRemoteDataSource extends Mock
    implements AuthRemoteDataSourceRepo {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemote;

  setUp(() {
    mockRemote = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemote);
  });

  const testCode = "1234";

  // ================================
  // ✅ SUCCESS CASE
  // ================================
  test('should return Right(BaseEntity) when verifyOtp succeeds',
          () async {
        final model = OtpModel();

        when(() => mockRemote.verifyOtp(testCode))
            .thenAnswer((_) async => Success<OtpModel>(model));

        final result = await repository.verifyOtpDomain(testCode);

        expect(result, Right(model));
        verify(() => mockRemote.verifyOtp(testCode)).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

  // ================================
  // ❌ FAILURE CASE
  // ================================
  test('should return Left(AppError) when verifyOtp fails', () async {
    final apiError = ApiErrorModel(message: "error");
    final failure = Failure<OtpModel>(apiError);

    when(() => mockRemote.verifyOtp(testCode))
        .thenAnswer((_) async => failure);

    final result = await repository.verifyOtpDomain(testCode);

    expect(result, isA<Left>());

    result.fold(
          (error) => expect(error.messege, "error"),
          (_) => fail("Expected failure"),
    );

    verify(() => mockRemote.verifyOtp(testCode)).called(1);
  });
}