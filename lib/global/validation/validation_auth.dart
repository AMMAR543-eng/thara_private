import 'package:get/get.dart';

class InputValidators {
  /// Validates if the input is not empty.
  static String? notEmpty(String? value, {String? errorMessage}) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage ?? 'error_required_field'.tr;
    }
    return null;
  }

  /// Validates an email address.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'error_enter_email'.tr;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'error_invalid_email'.tr;
    }
    return null;
  }

  /// Validates a password.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'error_enter_password'.tr;
    }

    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*(),.?":{}|<>])(?!.*\s).{8,}$',
    );

    if (!passwordRegex.hasMatch(value)) {
      return 'error_password_format'.tr;
    }

    return null;
  }

  /// Validates that the confirmation password matches the original password.
  static String? validateConfirmationPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'error_reenter_password'.tr;
    }
    if (value != password) {
      return 'error_password_mismatch'.tr;
    }
    return null;
  }

  /// Validates Saudi phone number.
  static String? validateSaudiPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'error_required_phone'.tr;
    }
    final regex = RegExp(r'^5\d{8}$');
    if (!regex.hasMatch(value.trim())) {
      return 'error_invalid_saudi_phone'.tr;
    }
    return null;
  }

  /// Validates Saudi IBAN format.
  static String? validateSaudiIban(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'error_required_iban'.tr;
    }
    if (!RegExp(r'^SA\d{22}$').hasMatch(value.trim().toUpperCase())) {
      return 'error_invalid_iban'.tr;
    }
    return null;
  }

  /// Validates commercial registration number.
  static String? validateCommercialNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'error_required_crn'.tr;
    }
    if (!RegExp(r'^[1-9][0-9]{9}$').hasMatch(value)) {
      return 'error_invalid_crn'.tr;
    }
    return null;
  }

  /// Validates identity number.
  static String? validateIdentityNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'error_enter_id'.tr;
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'error_id_numbers_only'.tr;
    }
    if (value.length > 10) {
      return 'error_id_max_length'.tr;
    }
    return null;
  }

  /// Validates bank account number.
  static String? validateBankAccountNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'error_required_account_number'.tr;
    }
    return null;
  }

  /// Combines multiple validators.
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}

final notEmptyValidator = (value) => InputValidators.notEmpty(value);
