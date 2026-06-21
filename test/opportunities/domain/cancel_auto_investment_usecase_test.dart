import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

class MockOpportunitiesRepository extends Mock
    implements OpportunitiesRepository {}

void main() {
  late CancelAutoInvestmentDomainUseCase useCase;
  late MockOpportunitiesRepository mockRepo;

  setUp(() {
    mockRepo = MockOpportunitiesRepository();
    useCase = CancelAutoInvestmentDomainUseCase(mockRepo);
  });

  test('should return Right(SuccessNewModel) when success', () async {
    final model = SuccessNewModel();

    when(() => mockRepo.cancelAutoInvestmentDomain())
        .thenAnswer((_) async => Right(model));

    final result = await useCase(NoParams());

    expect(result, Right(model));
    verify(() => mockRepo.cancelAutoInvestmentDomain()).called(1);
  });

  test('should return Left(AppError) when failure', () async {
    final error = AppError("error");

    when(() => mockRepo.cancelAutoInvestmentDomain())
        .thenAnswer((_) async => Left(error));

    final result = await useCase(NoParams());

    expect(result, isA<Left>());
  });
}