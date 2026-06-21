import '../../../index/index_main.dart';

class LoginResponseModel extends BaseModel {
  final LoginAccessModel? data;

  LoginResponseModel({
    this.data,
    int? customStatusCode,
    String? message,
    bool? debug,
    String? env,
    AccountModel? account,
    UserModel? user,
  }) : super(
          customStatusCode: customStatusCode,
          message: message,
          debug: debug,
          env: env,
          account: account,
          user: user,
        );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      data:
          json['data'] != null ? LoginAccessModel.fromJson(json['data']) : null,
      customStatusCode: json['customStatusCode'],
      message: json['message'],
      debug: json['debug'],
      env: json['env'],
      account: json['account'] != null
          ? AccountModel.fromJson(json['account'])
          : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      ...super.toJson(), // Spread the BaseModel's fields
    };
  }
}

class LoginAccessModel extends LoginEntity {
  @override
  final String? accessToken;

  const LoginAccessModel({this.accessToken}) : super(accessToken: accessToken);

  factory LoginAccessModel.fromJson(Map<String, dynamic> json) {
    return LoginAccessModel(accessToken: json['access_token'] as String?);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'access_token': accessToken};
  }
}

extension LoginAccessStorageExtension on LoginResponseModel {
  /// ✅ Save token locally
  Future<void> saveTokenLocal({Function? saveCallback}) async {
    final isSaved = await StorageService().setData(Strings.TOKEN, toJson());
    if (isSaved) {
      debugPrint("🔐 Token saved: ${toJson()}");
      saveCallback?.call();
    } else {
      Loader.showError("فشل في حفظ التوكن محلياً");
    }
  }

  /// ✅ Load token from local storage
  LoginResponseModel? getTokenData() {
    final json = StorageService().getData(Strings.TOKEN);

    if (json != null) {
      try {
        return LoginResponseModel.fromJson(json);
      } catch (e) {
        debugPrint(" Error decoding token: $e");
        return null;
      }
    }
    return null;
  }

  /// ✅ Delete token from local storage
  Future<void> deleteTokenLocal({Function? deleteCallback}) async {
    final isDeleted = await StorageService().remove(Strings.TOKEN);
    if (isDeleted) {
      debugPrint("🗑️ Token deleted");
      deleteCallback?.call();
    } else {
      Loader.showError("فشل في حذف التوكن");
    }
  }
}
