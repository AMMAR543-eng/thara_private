import '../../../../../../index/index_main.dart';

import 'dart:io';

class FileUploadField extends StatelessWidget {
  final String labelText;
  final String? filePath;
  final VoidCallback onPickFile;
  final VoidCallback? onRemoveFile;

  const FileUploadField({
    Key? key,
    required this.labelText,
    required this.onPickFile,
    this.filePath,
    this.onRemoveFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10,
        right: 10,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: context.typography.font42Grey.copyWith(
              color: AppColors.background_black,
            ),
          ),

          const SizedBox(height: 8),

          // Show Image Preview if File is Selected
          if (filePath != null && File(filePath!).existsSync())
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(filePath!), // Display selected image
                  width: double.infinity,
                  height: 300.h,
                  fit: BoxFit.fill,
                ),
              ),
            ),

          InkWell(
            onTap: onPickFile,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background_neutral_default,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderNeutralPrimary),
              ),
              child: Row(
                children: [
                  Icon(Icons.file_present, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      filePath ?? "إختر الملف المراد تحملية",
                      style: context.typography.font33Grey.copyWith(
                        color: AppColors.background_black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (filePath != null && onRemoveFile != null)
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: onRemoveFile,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Picks an image file (JPG, PNG, GIF, BMP, HEIC, etc.).
Future<String?> pickImage() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Restrict to images only
      allowMultiple: false, // Single file selection
      withData: false, // Ensure it returns a valid file path
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files.single.path; // Return the selected image path
    }
  } catch (e) {}
  return null; // Return null if no image is picked
}
