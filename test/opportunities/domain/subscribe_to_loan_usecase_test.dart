import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

class MockOpportunitiesRepository extends Mock
    implements OpportunitiesRepository {}

void main() {
  late SubscribeToLoanDomainUseCase useCase;
  late MockOpportunitiesRepository mockRepo;

  setUp(() {
    mockRepo = MockOpportunitiesRepository();
    useCase = SubscribeToLoanDomainUseCase(mockRepo);
  });

  final params = InvestSubscribeParam("123", 1000);

  test('should return Right(SuccessNewModel) when success', () async {
    final model = SuccessNewModel();

    when(() => mockRepo.subscribeToLoanDomain("123", 1000))
        .thenAnswer((_) async => Right(model));

    final result = await useCase(params);

    expect(result, Right(model));
    verify(() => mockRepo.subscribeToLoanDomain("123", 1000))
        .called(1);
  });

  test('should return Left(AppError) when failure', () async {
    final error = AppError("error");

    when(() => mockRepo.subscribeToLoanDomain("123", 1000))
        .thenAnswer((_) async => Left(error));

    final result = await useCase(params);

    expect(result, isA<Left>());
  });
}