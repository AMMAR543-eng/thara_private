import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../index/index_main.dart';

class GenericPdfViewer extends StatefulWidget {
  final String pdfUrl;
  final String fileName; // Should include extension (e.g., "document.pdf")

  const GenericPdfViewer({
    Key? key,
    required this.pdfUrl,
    required this.fileName,
  }) : super(key: key);

  @override
  State<GenericPdfViewer> createState() => _GenericPdfViewerState();
}

class _GenericPdfViewerState extends State<GenericPdfViewer> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool isDownloading = false;
  String? localPdfPath;
  late Future<Map<String, String>> _headersFuture;

  @override
  void initState() {
    super.initState();
    _headersFuture = ClientSourceRepo().defaultHeaders(); // Fetch headers once
  }

  Future<void> downloadPdf(Map<String, String> headers) async {
    Loader.show();
    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String filePath = path.join(appDir.path, widget.fileName);

      final response = await http.get(
        Uri.parse(widget.pdfUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes, flush: true);
        setState(() {
          localPdfPath = filePath;
        });
        Loader.showSuccess("تم تحميل الملف بنجاح");
      } else {
        Loader.showError("فشل تحميل الملف");
      }
    } catch (e) {
      Loader.showError("حدث خطأ أثناء تحميل الملف");
    } finally {
      Loader.dismiss();
    }
  }

  Future<void> openDownloadedPdf() async {
    if (localPdfPath == null) {
      Loader.showError("الملف غير متوفر. قم بالتحميل أولاً.");
      return;
    }
    final result = await OpenFile.open(localPdfPath!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _headersFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final headers = snapshot.data!;

        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            elevation: 1,
            title: Text(
              'عرض الملف',
              style: context.typography.headerXLarge.copyWith(
                color: AppColors.white,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.close, color: AppColors.white),
              onPressed: () => Get.back(),
            ),
            actions: [
              if (isDownloading)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(color: AppColors.white),
                )
              else
                IconButton(
                  icon: Icon(Icons.download, color: AppColors.white),
                  onPressed: () async {
                    setState(() => isDownloading = true);
                    await downloadPdf(headers); // ✅ use passed headers
                    setState(() => isDownloading = false);
                  },
                ),
              if (localPdfPath != null)
                IconButton(
                  icon: Icon(Icons.open_in_new, color: AppColors.white),
                  onPressed: openDownloadedPdf,
                ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SfPdfViewer.network(
                widget.pdfUrl,
                key: _pdfViewerKey,
                headers: headers, // ✅ set async headers here
              ),
            ),
          ),
        );
      },
    );
  }
}

// // Fetch sell contracts
void goViewPdf(String id, String url) {
  Get.to(
        () => GenericPdfViewer(
      fileName: "smfile$id.pdf",
      pdfUrl:
      "${ApiConstatns.Base_Url}${url.startsWith('/') ? url.substring(1) : url}",
    ),
    binding: Binding(),
  );
}