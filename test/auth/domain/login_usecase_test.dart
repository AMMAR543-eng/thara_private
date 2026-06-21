import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

// 🔥 Mock للـ Repository
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginDomainUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginDomainUseCase(mockRepository);
  });

  final testParams = LoginParams(
    email: "test@test.com",
    password: "123456",
  );

  final testMap = {
    "email": "test@test.com",
    "password": "123456",
  };

  // ================================
  // ✅ SUCCESS CASE
  // ================================
  test('should return Right(LoginResponseModel) when repository succeeds',
          () async {
        // arrange
        final model = LoginResponseModel();

        when(() => mockRepository.loginDomain(testMap))
            .thenAnswer((_) async => Right(model));

        // act
        final result = await useCase(testParams);

        // assert
        expect(result, Right(model));
        verify(() => mockRepository.loginDomain(testMap)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

  // ================================
  // ❌ FAILURE CASE
  // ================================
  test('should return Left(AppError) when repository fails', () async {
    // arrange
    final error = AppError("error");

    when(() => mockRepository.loginDomain(testMap))
        .thenAnswer((_) async => Left(error));

    // act
    final result = await useCase(testParams);

    // assert
    expect(result, isA<Left>());

    result.fold(
          (l) => expect(l.messege, "error"),
          (_) => fail("Expected failure but got success"),
    );

    verify(() => mockRepository.loginDomain(testMap)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}