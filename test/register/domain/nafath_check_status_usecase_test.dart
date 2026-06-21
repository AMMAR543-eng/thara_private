import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

class MockRegisterRepository extends Mock implements RegisterRepository {}

void main() {
  late NafathCheckStatusUseCase useCase;
  late MockRegisterRepository mockRepo;

  setUp(() {
    mockRepo = MockRegisterRepository();
    useCase = NafathCheckStatusUseCase(mockRepo);
  });

  test('should return Right(NafathStatusModel) when success', () async {
    final model = NafathStatusModel();

    when(() => mockRepo.nafathCheckStatusDomain(true))
        .thenAnswer((_) async => Right(model));

    final result = await useCase(true);

    expect(result, Right(model));
    verify(() => mockRepo.nafathCheckStatusDomain(true)).called(1);
  });

  test('should return Left(AppError) when failure', () async {
    final error = AppError("error");

    when(() => mockRepo.nafathCheckStatusDomain(true))
        .thenAnswer((_) async => Left(error));

    final result = await useCase(true);

    expect(result, isA<Left>());
  });
}