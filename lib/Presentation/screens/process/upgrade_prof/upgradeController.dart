import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:thara/index/index_main.dart';

import '../../../design_systems/widgets/upload_files/fille_upload_widget.dart';

class UploadController extends GetxController {
  /// Multiple selected requirements
  final Set<int> selectedRequirements = {};

  final Map<int, String?> uploadedFiles = {};
  final Map<int, double> uploadProgress = {};
  final Map<int, String?> uploadError = {};

  void selectRequirement(int index) {
    if (selectedRequirements.contains(index)) {
      selectedRequirements.remove(index);
    } else {
      selectedRequirements.add(index);
    }
    update();
  }

  Future<void> pickFile(int index) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'jpg',
        'jpeg',
        'png',
        'doc',
        'docx',
        'xls',
        'xlsx',
      ],
    );

    if (result != null && result.files.single.path != null) {
      uploadedFiles[index] = result.files.single.path!;
      uploadProgress[index] = 0.0;
      uploadError[index] = null;
      _simulateUpload(index);
      update();
    }
  }

  void setFile(int index, String path) {
    uploadedFiles[index] = path;
    uploadProgress[index] = 0.0;
    uploadError[index] = null;
    _simulateUpload(index);
    update();
  }

  void removeFile(int index) {
    uploadedFiles.remove(index);
    uploadProgress.remove(index);
    uploadError.remove(index);
    update();
  }

  void retryUpload(int index) {
    if (uploadedFiles[index] != null) {
      uploadError[index] = null;
      uploadProgress[index] = 0.0;
      _simulateUpload(index);
      update();
    }
  }

  FileUploadStatus getFileStatus(int index) {
    if (uploadedFiles[index] == null) return FileUploadStatus.initial;
    if (uploadError[index] != null) return FileUploadStatus.error;
    if ((uploadProgress[index] ?? 0) < 1.0) return FileUploadStatus.uploading;
    return FileUploadStatus.success;
  }

  void _simulateUpload(int index) async {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      uploadProgress[index] = i / 10;
      update();
    }
  }

  uploadData(QualifiedInvestorParam param) {
    ProcessService().upgradeToProfessional(
      params: QualifiedInvestorParamsWrapper(param: param),
      voidCallBack: (data) {
        ProcessController controller = initUseCase(() => ProcessController());
        controller.getMeData();
        controller.update();

        SettingsBasicInfoController settingsBasicInfoController = initUseCase(
          () => SettingsBasicInfoController(),
        );
        settingsBasicInfoController.getProfileData();
        settingsBasicInfoController.update();

        Get.back();
        Loader.showSuccess(data.message ?? "");
      },
    );
  }
}
