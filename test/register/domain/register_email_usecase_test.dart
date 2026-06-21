import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

// Mock Repo
class MockRegisterRepository extends Mock implements RegisterRepository {}

void main() {
  late RegisterEmailDomainUseCase useCase;
  late MockRegisterRepository mockRepo;

  setUp(() {
    mockRepo = MockRegisterRepository();
    useCase = RegisterEmailDomainUseCase(mockRepo);
  });

  final params = SignUpParam(
    email: "test@test.com",
    password: "123456",
    passwordConfirm: "123456",
    type: "email",
  );

  final map = params.toJson();

  test('should return Right(LoginEntity) when success', () async {
    final entity = LoginEntity();

    when(() => mockRepo.registerEmailDomain(map))
        .thenAnswer((_) async => Right(entity));

    final result = await useCase(params);

    expect(result, Right(entity));
    verify(() => mockRepo.registerEmailDomain(map)).called(1);
  });

  test('should return Left(AppError) when failure', () async {
    final error = AppError("error");

    when(() => mockRepo.registerEmailDomain(map))
        .thenAnswer((_) async => Left(error));

    final result = await useCase(params);

    expect(result, isA<Left>());
  });
}