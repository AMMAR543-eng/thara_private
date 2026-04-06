import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

class MockRegisterRepository extends Mock implements RegisterRepository {}

void main() {
  late NafathGetCodeUseCase useCase;
  late MockRegisterRepository mockRepo;

  setUp(() {
    mockRepo = MockRegisterRepository();
    useCase = NafathGetCodeUseCase(mockRepo);
  });

  test('should return Right(NafathCodeEntity) when success', () async {
    final entity = NafathCodeEntity();

    when(() => mockRepo.nafathGetCodeDomain(true))
        .thenAnswer((_) async => Right(entity));

    final result = await useCase(true);

    expect(result, Right(entity));
    verify(() => mockRepo.nafathGetCodeDomain(true)).called(1);
  });

  test('should return Left(AppError) when failure', () async {
    final error = AppError("error");

    when(() => mockRepo.nafathGetCodeDomain(true))
        .thenAnswer((_) async => Left(error));

    final result = await useCase(true);

    expect(result, isA<Left>());
  });
}