import 'dart:io';
import 'package:thara/index/index_main.dart';


class BuildFileWidget extends StatefulWidget {
  final KycItemEntity question;
  final KYCController kycController;

  const BuildFileWidget({
    super.key,
    required this.question,
    required this.kycController,
  });

  @override
  State<BuildFileWidget> createState() => _BuildFileWidgetState();
}

class _BuildFileWidgetState extends State<BuildFileWidget> {
  String? _filePath;

  @override
  void initState() {
    super.initState();

    /// Check if file answer already exists (e.g., user returned to the form)
    final existing = widget.kycController.questionsAnswers?.firstWhere(
      (e) => e.id == widget.question.id,
      orElse: () => KycItemEntity(),
    );

    if (existing?.file?.isNotEmpty == true) {
      _filePath = existing?.file!;
    }
  }

  void _onPickFile(String? filePath) {
    if (filePath == null) return;

    setState(() => _filePath = filePath);

    final index = widget.kycController.questionsAnswers?.indexWhere(
      (e) => e.id == widget.question.id,
    );

    final fileEntity = KycItemEntity(
      id: widget.question.id,
      category: widget.question.category,
      type: widget.question.type,
      file: filePath,
    );

    if (index == null || index == -1) {
      widget.kycController.questionsAnswers?.add(fileEntity);
    } else {
      widget.kycController.questionsAnswers?[index!] = fileEntity;
    }

    widget.kycController.update();
  }

  void _onRemoveFile() {
    setState(() => _filePath = null);

    final index = widget.kycController.questionsAnswers?.indexWhere(
      (e) => e.id == widget.question.id,
    );

    if (index != null && index >= 0) {
      widget.kycController.questionsAnswers?.removeAt(index);
    }

    widget.kycController.update();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: FileUploadWidget(
        status: _filePath == null
            ? FileUploadStatus.initial
            : FileUploadStatus.success,
        // you can also handle error/uploading
        fileName: _filePath != null
            ? File(_filePath!).uri.pathSegments.last
            : null,
        fileSize: _filePath != null
            ? File(_filePath!).lengthSync() / (1024 * 1024)
            : null,
        progress: 0.0,
        // or bind to actual upload progress
        errorMessage: null,
        onPickFile: () async {
          final selected = await pickImage();
          _onPickFile(selected);
        },
        onRemoveFile: _onRemoveFile,
        onRetry: () => _onPickFile(_filePath),
        onReplace: () async {
          final selected = await pickImage();
          _onPickFile(selected);
        },
      ),
    );
  }
}
