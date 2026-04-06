import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:thara/index/index_main.dart' hide test;

// 🔥 Mock Service
class MockAuthService extends Mock implements AuthService {}

void main() {
    late LoginController controller;
    late MockAuthService mockService;

    setUpAll(() {
      registerFallbackValue(LoginParams(email: '', password: ''));
    });

    setUp(() {
      mockService = MockAuthService();
      controller = LoginController(authService: mockService);
    });

  // ================================
  // ✅ toggle password
  // ================================
  test('should toggle password visibility', () {
    controller.showPassword = false;

    controller.togglePasswordVisibility();

    expect(controller.showPassword, true);
  });

  // ================================
  // ✅ validation logic
  // ================================
  test('should update email validation', () {
    controller.updateEmailValidation(true);

    expect(controller.validEmail, true);
  });

  test('should update password validation', () {
    controller.updatePasswordValidation(true);

    expect(controller.validPassword, true);
  });

  test('should return true when both validations are true', () {
    controller.updateEmailValidation(true);
    controller.updatePasswordValidation(true);

    expect(controller.canLogin, true);
  });

  // ================================
  // 🔥 LOGIN TEST (IMPORTANT)
  // ================================
  test('should call AuthService.login when login is triggered', () {
    // arrange
    const email = "test@test.com";
    const password = "123456";

    when(() => mockService.login(
      params: any(named: 'params'),
      voidCallBack: any(named: 'voidCallBack'),
    )).thenAnswer((_) async {});

    // act
    controller.login(email, password, FakeBuildContext(), null);

    // assert
    verify(() => mockService.login(
      params: any(named: 'params'),
      voidCallBack: any(named: 'voidCallBack'),
    )).called(1);
  });
}

// 🔥 fake context
class FakeBuildContext extends Fake implements BuildContext {}