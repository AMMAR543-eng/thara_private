import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

class MockOpportunitiesRepository extends Mock
    implements OpportunitiesRepository {}

void main() {
  late CancelSubscriptionDomainUseCase useCase;
  late MockOpportunitiesRepository mockRepo;

  setUp(() {
    mockRepo = MockOpportunitiesRepository();
    useCase = CancelSubscriptionDomainUseCase(mockRepo);
  });

  test('should return Right(SuccessNewModel) when success', () async {
    final model = SuccessNewModel();

    when(() => mockRepo.cancelSubscriptionDomain("123"))
        .thenAnswer((_) async => Right(model));

    final result = await useCase("123");

    expect(result, Right(model));
    verify(() => mockRepo.cancelSubscriptionDomain("123")).called(1);
  });

  test('should return Left(AppError) when failure', () async {
    final error = AppError("error");

    when(() => mockRepo.cancelSubscriptionDomain("123"))
        .thenAnswer((_) async => Left(error));

    final result = await useCase("123");

    expect(result, isA<Left>());
  });
}