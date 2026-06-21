import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

class MockRegisterRepository extends Mock implements RegisterRepository {}

void main() {
  late SingingWithSirarUseCase useCase;
  late MockRegisterRepository mockRepo;

  setUp(() {
    mockRepo = MockRegisterRepository();
    useCase = SingingWithSirarUseCase(mockRepo);
  });

  test('should return Right(BaseEntity) when success', () async {
    final entity = BaseEntity();

    when(() => mockRepo.singingWithSirarDomain())
        .thenAnswer((_) async => Right(entity));

    final result = await useCase(NoParams());

    expect(result, Right(entity));
    verify(() => mockRepo.singingWithSirarDomain()).called(1);
  });

  test('should return Left(AppError) when failure', () async {
    final error = AppError("error");

    when(() => mockRepo.singingWithSirarDomain())
        .thenAnswer((_) async => Left(error));

    final result = await useCase(NoParams());

    expect(result, isA<Left>());
  });
}