import '../../../index/index_main.dart';

class UserAuthResponse {
  final UserModel data;
  final String message;
  final int status;

  UserAuthResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  /// Factory method to parse JSON
  factory UserAuthResponse.fromJson(Map<String, dynamic> json) {
    return UserAuthResponse(
      data: UserModel.fromJson(json['data']),
      message: json['message'] as String,
      status: json['status'] as int,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {"data": data.toJson(), "message": message, "status": status};
  }
}

/// ✅ UserModel now includes bioToken + udid + clean JSON serialization
class UserModel extends UserEntity {
  UserModel({
    final String? name,
    final String? biometricPassword,
    final String? email,
    final String? type,
    final String? phoneNumber,
    final String? nin,
    final String? userType,
    final bool? twoFactorCodeSent,
    final bool? passTwoFactor,
    final bool? needPassword,
  }) : super(
          name: name,
          email: email,
          type: type,
          biometricPassword: biometricPassword,
          phoneNumber: phoneNumber,
          nin: nin,
          userType: userType,
          twoFactorCodeSent: twoFactorCodeSent,
          passTwoFactor: passTwoFactor,
          needPassword: needPassword,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String?,
      biometricPassword: json['biometric_password'] as String?,
      type: json['type'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      nin: json['nin'] as String?,
      userType: json['user_type'] as String?,
      twoFactorCodeSent: json['twoFactorCodeSent'] as bool?,
      passTwoFactor: json['passTwoFactor'] as bool?,
      needPassword: json['needPassword'] as bool?,
      // ✅ Added
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'type': type,
      'biometric_password': biometricPassword,
      'email': email,
      'phone_number': phoneNumber,
      'nin': nin,
      'user_type': userType,
      'twoFactorCodeSent': twoFactorCodeSent,
      'passTwoFactor': passTwoFactor,
      'needPassword': needPassword,
    };

    return data;
  }
}

extension SaveProductsData on UserModel {
  /// ✅ Save user data locally
  Future<void> saveUserLocal({Function? saveCallback}) async {
    final isSaved = await StorageService().setData(Strings.user, toJson());
    if (isSaved) {
      saveCallback?.call();
    } else {
      Loader.showError("Not saved locally");
    }
  }

  /// ✅ Retrieve user data from local storage
  UserModel? getUserData() {
    final productJson = StorageService().getData(Strings.user);
    if (productJson != null) {
      try {
        return UserModel.fromJson(productJson);
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  /// ✅ Delete user data from local storage
  Future<void> deleteUserLocal({Function? deleteCallback}) async {
    final isDeleted = await StorageService().remove(Strings.user);
    if (isDeleted) {
      deleteCallback?.call();
    } else {
      Loader.showError("Failed to delete user data");
    }
  }
}
