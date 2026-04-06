import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

// 🔥 Mock Remote
class MockOpportunitiesRemote extends Mock
    implements OpportunitiesRemoteDataSourceRepo {}

void main() {
  late OpportunitiesRepositoryImpl repository;
  late MockOpportunitiesRemote mockRemote;

  setUp(() {
    mockRemote = MockOpportunitiesRemote();
    repository = OpportunitiesRepositoryImpl(mockRemote);
  });

  tearDown(() {
    reset(mockRemote);
  });

  final testMap = {"page": 1};

  // ================================
  // ✅ GET OPPORTUNITIES SUCCESS
  // ================================
  test('should return Right(GetOpportunitiesEntity) when success', () async {
    final model = OpportunitiesResponse();

    when(() => mockRemote.getOpportunities(testMap))
        .thenAnswer((_) async => Success<OpportunitiesResponse>(model));

    final result = await repository.getOpportunitiesDomain(testMap);

    expect(result, isA<Right>());
    verify(() => mockRemote.getOpportunities(testMap)).called(1);
  });

  // ================================
  // ❌ GET OPPORTUNITIES FAILURE
  // ================================
  test('should return Left(AppError) when failure', () async {
    final failure =
    Failure<OpportunitiesResponse>(ApiErrorModel(message: "error"));

    when(() => mockRemote.getOpportunities(testMap))
        .thenAnswer((_) async => failure);

    final result = await repository.getOpportunitiesDomain(testMap);

    expect(result, isA<Left>());
  });

  // ================================
  // ✅ SUBSCRIBE SUCCESS
  // ================================
  test('should return Right(SuccessNewModel) when subscribe succeeds',
          () async {
        final model = SuccessNewModel();

        when(() => mockRemote.subscribeToLoan("123", 1000))
            .thenAnswer((_) async => Success<SuccessNewModel>(model));

        final result =
        await repository.subscribeToLoanDomain("123", 1000);

        expect(result, isA<Right>());
        verify(() => mockRemote.subscribeToLoan("123", 1000)).called(1);
      });

  // ================================
  // ❌ SUBSCRIBE FAILURE
  // ================================
  test('should return Left(AppError) when subscribe fails', () async {
    final failure =
    Failure<SuccessNewModel>(ApiErrorModel(message: "error"));

    when(() => mockRemote.subscribeToLoan("123", 1000))
        .thenAnswer((_) async => failure);

    final result =
    await repository.subscribeToLoanDomain("123", 1000);

    expect(result, isA<Left>());
  });

  // ================================
  // ✅ CANCEL AUTO INVEST SUCCESS
  // ================================
  test('should return Right(SuccessNewModel) when cancel auto succeeds',
          () async {
        final model = SuccessNewModel();

        when(() => mockRemote.cancelAutoInvestment())
            .thenAnswer((_) async => Success<SuccessNewModel>(model));

        final result = await repository.cancelAutoInvestmentDomain();

        expect(result, isA<Right>());
        verify(() => mockRemote.cancelAutoInvestment()).called(1);
      });

  // ================================
  // ❌ CANCEL AUTO INVEST FAILURE
  // ================================
  test('should return Left(AppError) when cancel auto fails', () async {
    final failure =
    Failure<SuccessNewModel>(ApiErrorModel(message: "error"));

    when(() => mockRemote.cancelAutoInvestment())
        .thenAnswer((_) async => failure);

    final result = await repository.cancelAutoInvestmentDomain();

    expect(result, isA<Left>());
  });
}