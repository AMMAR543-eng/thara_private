import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late VerifyOtpDomainUseCase useCase;
  late MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = VerifyOtpDomainUseCase(mockRepo);
  });

  const code = "1234";

  // ================================
  // ✅ SUCCESS
  // ================================
  test('should return success when repository succeeds', () async {
    final model = OtpModel();

    when(() => mockRepo.verifyOtpDomain(code))
        .thenAnswer((_) async => Right(model));

    final result = await useCase(OtpParams(code: code));

    expect(result, Right(model));
    verify(() => mockRepo.verifyOtpDomain(code)).called(1);
  });

  // ================================
  // ❌ FAILURE
  // ================================
  test('should return failure when repository fails', () async {
    final error = AppError("error");

    when(() => mockRepo.verifyOtpDomain(code))
        .thenAnswer((_) async => Left(error));

    final result = await useCase(OtpParams(code: code));

    expect(result, isA<Left>());
  });
}