import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

class MockAuthRemoteDataSource extends Mock
    implements AuthRemoteDataSourceRepo {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemote;

  setUp(() {
    mockRemote = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemote);
  });

  tearDown(() {
    reset(mockRemote);
  });

  // ================================
  // ✅ SUCCESS
  // ================================
  test('should return Right(BaseEntity) when resendOtp succeeds',
          () async {
        final model = OtpModel();

        when(() => mockRemote.resendOtp())
            .thenAnswer((_) async => Success<OtpModel>(model));

        final result = await repository.resendOtpDomain();

        expect(result, Right(model));
        verify(() => mockRemote.resendOtp()).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

  // ================================
  // ❌ FAILURE
  // ================================
  test('should return Left(AppError) when resendOtp fails', () async {
    final apiError = ApiErrorModel(message: "error");
    final failure = Failure<OtpModel>(apiError);

    when(() => mockRemote.resendOtp())
        .thenAnswer((_) async => failure);

    final result = await repository.resendOtpDomain();

    expect(result, isA<Left>());

    result.fold(
          (error) => expect(error.messege, "error"),
          (_) => fail("Expected failure"),
    );

    verify(() => mockRemote.resendOtp()).called(1);
  });
}