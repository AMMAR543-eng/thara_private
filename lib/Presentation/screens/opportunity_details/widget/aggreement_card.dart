import 'package:thara/Global/Utils/pdf_viewer.dart';
import 'package:thara/Presentation/screens/opportunity_details/widgets/attatchment_tab.dart';
import '../../../../index/index_main.dart';

class InvestmentAgreementCard extends StatelessWidget {
  final OpportunitiesItemsEntity? opportunity;
  final OpportunityDetailsController controller;

  const InvestmentAgreementCard({
    super.key,
    required this.opportunity,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 10.h),
      decoration: BoxDecoration(
        color: LocalStorageTheme().read() == "light"
            ? AppColors.background_banner
            : AppColors.content_secondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border_natural_normal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 PDF icon
          SvgPicture.asset(
            IconsConstants.pdf_file_icom,
            width: 32.w,
            height: 32.h,
          ),
          const SizedBox(height: 10),

          /// 🔹 Attachments List
          AttachmentsTab(attatches: opportunity?.attachments ?? []),
        ],
      ),
    );
  }
}
