import 'package:collection/collection.dart'; // for `firstWhereOrNull`

enum StepType {
  emailVerification,
  basicInfo,
  nafath,
  kyc,
  signing,
}

extension StepTypeExtension on StepType {
  String get key {
    switch (this) {
      case StepType.emailVerification:
        return 'email_verification';
      case StepType.basicInfo:
        return 'basic_info';
      case StepType.nafath:
        return 'nafath';
      case StepType.kyc:
        return 'kyc';
      case StepType.signing:
        return 'signing';
    }
  }

  static StepType? fromKey(String? key) {
    return StepType.values.firstWhereOrNull((e) => e.key == key);
  }
}


