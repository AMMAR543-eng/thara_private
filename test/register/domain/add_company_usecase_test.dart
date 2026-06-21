import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:thara/index/index_main.dart' hide test;

class MockRegisterRepository extends Mock implements RegisterRepository {}

void main() {
  late AddCompanyDomainUseCase useCase;
  late MockRegisterRepository mockRepo;

  setUp(() {
    mockRepo = MockRegisterRepository();
    useCase = AddCompanyDomainUseCase(mockRepo);
  });

  final params = CompanyParam(
    name: "Test Company",
    fieldOfBusiness: "IT",
    crn: "123456",
    unifiedNumber: "654321",
    citizenship: "SA",
    phoneNumber: "0555555555",
    nin: "1234567890",
    dob: "1990-01-01",
  );

  final map = params.toJson();

  // ================================
  // ✅ SUCCESS
  // ================================
  test('should return Right(BaseEntity) when success', () async {
    final entity = BaseEntity();

    when(() => mockRepo.addCompanyDomain(map))
        .thenAnswer((_) async => Right(entity));

    final result = await useCase(params);

    expect(result, Right(entity));
    verify(() => mockRepo.addCompanyDomain(map)).called(1);
    verifyNoMoreInteractions(mockRepo);
  });

  // ================================
  // ❌ FAILURE
  // ================================
  test('should return Left(AppError) when failure', () async {
    final error = AppError("error");

    when(() => mockRepo.addCompanyDomain(map))
        .thenAnswer((_) async => Left(error));

    final result = await useCase(params);

    expect(result, isA<Left>());

    result.fold(
          (l) => expect(l.messege, "error"),
          (_) => fail("Expected failure"),
    );

    verify(() => mockRepo.addCompanyDomain(map)).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}