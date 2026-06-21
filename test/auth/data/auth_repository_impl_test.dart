import 'package:dartz/dartz.dart';
import 'package:thara/index/index_main.dart' hide test;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// 🔥 Mock للداتا سورس
class MockAuthRemoteDataSource extends Mock
    implements AuthRemoteDataSourceRepo {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemote;

  setUp(() {
    mockRemote = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemote);
  });

  tearDown(() {
    reset(mockRemote);
  });

  final testData = {
    "email": "test@test.com",
    "password": "123456"
  };

  // ================================
  // ✅ SUCCESS CASE
  // ================================
  test('should return Right(LoginResponseModel) when login is successful',
          () async {
        // arrange
        final model = LoginResponseModel();

        when(() => mockRemote.login(testData))
            .thenAnswer((_) async => Success<LoginResponseModel>(model));

        // act
        final result = await repository.loginDomain(testData);

        // assert
        expect(result, Right(model));
        verify(() => mockRemote.login(testData)).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

  // ================================
  // ❌ FAILURE CASE
  // ================================
  test('should return Left(AppError) when login fails', () async {
    // arrange
    final apiError = ApiErrorModel(message: "error");
    final failure = Failure<LoginResponseModel>(apiError);

    when(() => mockRemote.login(testData))
        .thenAnswer((_) async => failure);

    // act
    final result = await repository.loginDomain(testData);

    // assert
    expect(result, isA<Left>());

    result.fold(
          (error) => expect(error.messege, "error"),
          (_) => fail("Expected failure but got success"),
    );

    verify(() => mockRemote.login(testData)).called(1);
    verifyNoMoreInteractions(mockRemote);
  });
}