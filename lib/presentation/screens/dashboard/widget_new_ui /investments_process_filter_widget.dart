import 'package:thara/Presentation/design_systems/widgets/date_picker/date_picker_general.dart';
import '../../../../index/index_main.dart';

class InvestmentTransactionsFilterSheet {
  static void open(BuildContext context, DashboardController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _FilterContent(controller: controller),
    );
  }
}

class _FilterContent extends StatefulWidget {
  final DashboardController controller;

  const _FilterContent({required this.controller});

  @override
  State<_FilterContent> createState() => _FilterContentState();
}

class _FilterContentState extends State<_FilterContent> {
  GenericListModel? selectedStatus;
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final List<GenericListModel> statusList = [
    GenericListModel(id: 0, name: "status_active".tr, text: "active"),
    GenericListModel(id: 1, name: "status_closed".tr, text: "closed"),
    GenericListModel(id: 2, name: "status_on_hold".tr, text: "on_hold"),
    GenericListModel(id: 3, name: "status_canceled".tr, text: "canceled"),
  ];

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.controller.selectedStatusFilter;
    startDateController.text = widget.controller.startDateFilter ?? "";
    endDateController.text = widget.controller.endDateFilter ?? "";
    searchController.text = widget.controller.searchTextFilter ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20.w,
          right: 20.w,
          top: 20.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// --- Handle Indicator
              Container(
                width: 50.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border_default,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 16.h),

              /// --- Title
              Text(
                'filter_investment_transactions'.tr,
                style: context.typography.bodyStrongMedium.copyWith(
                  color: AppColors.content_primary,
                ),
              ),
              SizedBox(height: 24.h),

              /// --- Search Field
              AppTextField(
                controller: searchController,
                hintText: "search_in_all_results".tr,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(IconsConstants.search),
                ),
              ),
              SizedBox(height: 20.h),

              /// --- Status Dropdown
              GenericNewDropdown<GenericListModel>(
                title: "investment_status".tr,
                hint: "please_select".tr,
                items: statusList,
                selectedItem: selectedStatus,
                itemLabel: (item) => item.name ?? "",
                onChanged: (value) => setState(() => selectedStatus = value),
              ),
              SizedBox(height: 20.h),

              /// --- Date Range Pickers
              Row(
                children: [
                  Expanded(
                    child: _datePickerField(
                      context: context,
                      controller: startDateController,
                      label: 'start_date_range'.tr,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _datePickerField(
                      context: context,
                      controller: endDateController,
                      label: 'end_date_range'.tr,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.h),

              /// --- Apply Button
              SizedBox(
                width: ScreenUtil().screenWidth,
                child: PrimaryTextButton(
                  onTap: () {
                    widget.controller.selectedStatusFilter = selectedStatus;
                    widget.controller.startDateFilter =
                    startDateController.text.isEmpty
                        ? null
                        : startDateController.text;
                    widget.controller.endDateFilter =
                    endDateController.text.isEmpty
                        ? null
                        : endDateController.text;
                    widget.controller.searchTextFilter =
                    searchController.text.isEmpty
                        ? null
                        : searchController.text;

                    widget.controller.getInvests();
                    widget.controller.update();
                    Get.back();
                  },
                  label: Text(
                    'apply_filters'.tr,
                    style: context.typography.bodyLarge.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14.h),

              /// --- Cancel All Button
              OutlinedButton(
                onPressed: () {
                  widget.controller.selectedStatusFilter = null;
                  widget.controller.startDateFilter = null;
                  widget.controller.endDateFilter = null;
                  widget.controller.searchTextFilter = null;
                  widget.controller.getInvests();
                  widget.controller.update();
                  Get.back();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.border_default),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  minimumSize: Size(double.infinity, 48.h),
                ),
                child: Text(
                  'cancel_all_filters'.tr,
                  style: context.typography.bodyLarge.copyWith(
                    color: AppColors.content_secondary,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  /// --- Custom Date Picker Field
  Widget _datePickerField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
  }) {
    return GestureDetector(
      onTap: () async {
        showCustomBottomSheet(
          context: context,
          padding: EdgeInsets.zero,
          child: CalendarPickerGeneralView(controller: controller),
        );
        setState(() {});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.typography.bodyLarge.copyWith(
              color: AppColors.content_primary,
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.border_natural_normal,
                width: 1,
              ),
              color: AppColors.background_neutral_surface,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    controller.text.isEmpty
                        ? 'please_select'.tr
                        : controller.text,
                    style: context.typography.bodyMedium.copyWith(
                      color: controller.text.isEmpty
                          ? AppColors.content_secondary
                          : AppColors.content_primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: AppColors.content_secondary,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
