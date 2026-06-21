import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late ResendOtpDomainUseCase useCase;
  late MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = ResendOtpDomainUseCase(mockRepo);
  });

  test('should return success when repository succeeds', () async {
    final model = OtpModel();

    when(() => mockRepo.resendOtpDomain())
        .thenAnswer((_) async => Right(model));

    final result = await useCase(NoParams());

    expect(result, Right(model));
    verify(() => mockRepo.resendOtpDomain()).called(1);
  });

  test('should return failure when repository fails', () async {
    final error = AppError("error");

    when(() => mockRepo.resendOtpDomain())
        .thenAnswer((_) async => Left(error));

    final result = await useCase(NoParams());

    expect(result, isA<Left>());
  });
}