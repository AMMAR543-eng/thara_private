import 'package:thara/index/index_main.dart';

class AccountModel {
  final String? id;
  final String? ownerName;
  final bool? verifiedAsInvestor;
  final bool? verifiedAsBorrower;
  final bool? isProfessionalInvestor;
  final bool? thereIsWaitingRequest;
  final String? registrationStage;
  final String? activateAnotherAccountStage;
  final String? investingAccountStatus;
  final String? borrowingAccountStatus;
  final String? accountStatus;
  final bool? nafathCompleted;
  final String? yaqeenProblem;
  final bool? hasBankAccount;
  final String? applyingAs;
  final String? type;
  final bool? hasBlockedBalance;
  final List<ActivateAnotherAccountStep>? steps;
  final List<ActivateAnotherAccountStep>? activateAnotherAccountSteps;
  final VirtualAccountModel? virtualAccount;

  /// 🆕 Added profile photo model
  final ProfilePhotoModel? profilePhoto;

  const AccountModel({
    this.id,
    this.ownerName,
    this.verifiedAsInvestor,
    this.verifiedAsBorrower,
    this.isProfessionalInvestor,
    this.thereIsWaitingRequest,
    this.registrationStage,
    this.activateAnotherAccountStage,
    this.investingAccountStatus,
    this.borrowingAccountStatus,
    this.accountStatus,
    this.nafathCompleted,
    this.yaqeenProblem,
    this.hasBankAccount,
    this.applyingAs,
    this.type,
    this.hasBlockedBalance,
    this.steps,
    this.activateAnotherAccountSteps,
    this.virtualAccount,
    this.profilePhoto, // ✅ added field
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    final stepsList = json['steps'] as List?;
    final activateStepsList = json['activateAnotherAccountSteps'] as List?;

    return AccountModel(
      id: json['id'],
      ownerName: json['ownerName'],
      verifiedAsInvestor: json['verified_as_investor'],
      verifiedAsBorrower: json['verified_as_borrower'],
      isProfessionalInvestor: json['is_professional_investor'],
      thereIsWaitingRequest: json['thereIsWaitingRequest'],
      registrationStage: json['registration_stage'],
      activateAnotherAccountStage: json['activate_another_account_stage'],
      investingAccountStatus: json['investing_account_status'],
      borrowingAccountStatus: json['borrowing_account_status'],
      accountStatus: json['account_status'],
      nafathCompleted: json['nafath_completed'],
      yaqeenProblem: json['yaqeen_problem'],
      hasBankAccount: json['has_bank_account'],
      applyingAs: json['applying_as'],
      type: json['type'],
      hasBlockedBalance: json['hasBlockedBalance'],
      steps: stepsList != null
          ? stepsList
              .map((e) => ActivateAnotherAccountStep.fromJson(e))
              .toList()
          : [],
      activateAnotherAccountSteps: activateStepsList != null
          ? activateStepsList
              .map((e) => ActivateAnotherAccountStep.fromJson(e))
              .toList()
          : [],
      virtualAccount: json['virtualAccount'] != null
          ? VirtualAccountModel.fromJson(json['virtualAccount'])
          : null,
      profilePhoto: json['profile_photo'] != null
          ? ProfilePhotoModel.fromJson(json['profile_photo'])
          : null, // ✅ Added mapping
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'ownerName': ownerName,
        'verified_as_investor': verifiedAsInvestor,
        'verified_as_borrower': verifiedAsBorrower,
        'is_professional_investor': isProfessionalInvestor,
        'thereIsWaitingRequest': thereIsWaitingRequest,
        'registration_stage': registrationStage,
        'activate_another_account_stage': activateAnotherAccountStage,
        'investing_account_status': investingAccountStatus,
        'borrowing_account_status': borrowingAccountStatus,
        'account_status': accountStatus,
        'nafath_completed': nafathCompleted,
        'yaqeen_problem': yaqeenProblem,
        'has_bank_account': hasBankAccount,
        'applying_as': applyingAs,
        'type': type,
        'hasBlockedBalance': hasBlockedBalance,
        'steps': steps?.map((e) => e.toJson()).toList(),
        'activateAnotherAccountSteps':
            activateAnotherAccountSteps?.map((e) => e.toJson()).toList(),
        'virtualAccount': virtualAccount?.toJson(),
        'profile_photo': profilePhoto?.toJson(), // ✅ added field
      };
}

/// 🆕 New model for Profile Photo
class ProfilePhotoModel {
  final int? id;
  final String? url;
  final String? mime;

  const ProfilePhotoModel({this.id, this.url, this.mime});

  factory ProfilePhotoModel.fromJson(Map<String, dynamic> json) {
    return ProfilePhotoModel(
      id: json['id'] as int?,
      url: json['url'] as String?,
      mime: json['mime'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'mime': mime,
      };
}

class VirtualAccountModel {
  final String? accountNumber;
  final String? iban;

  const VirtualAccountModel({this.accountNumber, this.iban});

  factory VirtualAccountModel.fromJson(Map<String, dynamic> json) {
    return VirtualAccountModel(
      accountNumber: json['account_number'] as String?,
      iban: json['iban'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'account_number': accountNumber,
        'iban': iban,
      };
}

class ActivateAnotherAccountStep {
  final String? key;
  final bool? active;
  final String? component;

  const ActivateAnotherAccountStep({this.key, this.active, this.component});

  factory ActivateAnotherAccountStep.fromJson(Map<String, dynamic> json) {
    return ActivateAnotherAccountStep(
      key: json['key'] as String?,
      active: json['active'] as bool?,
      component: json['component'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'active': active,
        'component': component,
      };
}

StepType? getActiveStep(List<ActivateAnotherAccountStep> steps) {
  final activeStep = steps.firstWhereOrNull((step) => step.active == true);
  return StepTypeExtension.fromKey(activeStep?.key);
}

extension AccountStorageExtension on AccountModel {
  /// ✅ Save account locally
  Future<void> saveAccountLocal({Function? onSaved}) async {
    final isSaved = await StorageService().setData(Strings.account, toJson());
    if (isSaved) {
      debugPrint(" Account saved locally: ${toJson()}");
      onSaved?.call();
    } else {
      Loader.showError("فشل في حفظ بيانات الحساب محلياً");
    }
  }

  /// ✅ Load account from local storage
  AccountModel? getAccountLocal() {
    final json = StorageService().getData(Strings.account);
    if (json != null) {
      try {
        return AccountModel.fromJson(json);
      } catch (e) {
        debugPrint("Error decoding account from local storage: $e");
        return null;
      }
    }
    return null;
  }

  /// ✅ Delete account from local storage
  Future<void> deleteAccountLocal({Function? onDeleted}) async {
    final isDeleted = await StorageService().remove(Strings.account);
    if (isDeleted) {
      debugPrint("🗑️ Account deleted from local storage");
      onDeleted?.call();
    } else {
      Loader.showError("فشل في حذف بيانات الحساب");
    }
  }
}
