import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../index/index_main.dart';

class GenericPdfViewerFromAsset extends StatelessWidget {
  final String assetPath;
  final String title;

  const GenericPdfViewerFromAsset({
    Key? key,
    required this.assetPath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background_black,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              CustomPdfHeader(title),
              Expanded(
                child: Container(
                  color: AppColors.white,
                  child: SfPdfViewer.asset(assetPath),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomPdfHeader(String title) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: const Border(
          bottom: BorderSide(color: AppColors.border_natural_normal, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// Centered Title
          Text(
            title,
            style: Get.context!.typography.headerLarge.copyWith(
              color: AppColors.textDefault,
            ),
            textAlign: TextAlign.center,
          ),

          /// Right Action
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Text(
                "Cancel".tr,
                style: Get.context!.typography.headerLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
