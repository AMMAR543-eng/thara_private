import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

class MockOpportunitiesRepository extends Mock
    implements OpportunitiesRepository {}

void main() {
  late GetOpportunitiesUseCase useCase;
  late MockOpportunitiesRepository mockRepo;

  setUp(() {
    mockRepo = MockOpportunitiesRepository();
    useCase = GetOpportunitiesUseCase(mockRepo);
  });

  final params = OpportunityParameter(); // حسب constructor
  final map = params.toJson();

  test('should return Right(GetOpportunitiesEntity) when success', () async {
    final entity = GetOpportunitiesEntity();

    when(() => mockRepo.getOpportunitiesDomain(map))
        .thenAnswer((_) async => Right(entity));

    final result = await useCase(params);

    expect(result, Right(entity));
    verify(() => mockRepo.getOpportunitiesDomain(map)).called(1);
  });

  test('should return Left(AppError) when failure', () async {
    final error = AppError("error");

    when(() => mockRepo.getOpportunitiesDomain(map))
        .thenAnswer((_) async => Left(error));

    final result = await useCase(params);

    expect(result, isA<Left>());
  });
}