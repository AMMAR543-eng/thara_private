import '../../../../index/index_main.dart';

class BioUserModel {
  String? bioToken;
  bool? isBiometric;
  String? uuid;

  BioUserModel({
    this.bioToken,
    this.isBiometric,
    this.uuid,
  });

  /// 🔁 Convert to JSON (only non-null fields)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (bioToken != null && bioToken!.isNotEmpty) {
      data['bio_token'] = bioToken;
    }
    if (isBiometric != null) {
      data['is_biometric'] = isBiometric;
    }
    if (uuid != null && uuid!.isNotEmpty) {
      data['uuid'] = uuid;
    }

    return data;
  }

  /// 🔄 Create from JSON
  factory BioUserModel.fromJson(Map<String, dynamic> json) {
    return BioUserModel(
      bioToken: json['bio_token'] as String?,
      isBiometric: json['is_biometric'] as bool?,
      uuid: json['uuid'] as String?,
    );
  }

  static const String _bioKey = 'bio_user_data';

  /// 💾 Save biometric data locally
  Future<void> saveBioLocal({Function? onSaved}) async {
    final json = toJson();

    if (json.isEmpty) {
      Loader.showError("⚠️ Nothing to save — all fields are null or empty");
      return;
    }

    final isSaved = await StorageService().setData(_bioKey, json);
    if (isSaved) {
      print("✅ Biometric data saved locally: $json");
      onSaved?.call();
    } else {
      Loader.showError("❌ Failed to save biometric data locally");
    }
  }

  /// 📥 Retrieve biometric data
  static BioUserModel? getBioData() {
    final bioJson = StorageService().getData(_bioKey);
    if (bioJson != null) {
      try {
        return BioUserModel.fromJson(bioJson);
      } catch (e) {
        print("⚠️ Error parsing biometric data: $e");
        return null;
      }
    }
    return null;
  }

  /// 🧹 Delete biometric data
  static Future<void> deleteBioLocal({Function? onDeleted}) async {
    final isDeleted = await StorageService().remove(_bioKey);
    if (isDeleted) {
      print("🧹 Biometric data deleted successfully");
      onDeleted?.call();
    } else {
      Loader.showError("❌ Failed to delete biometric data");
    }
  }
}
