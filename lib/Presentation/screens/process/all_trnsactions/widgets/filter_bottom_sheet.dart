import 'package:thara/Presentation/design_systems/widgets/date_picker/date_picker_general.dart';
import '../../../../../../index/index_main.dart';

class TransactionFilterBottomSheet {
  static void open(
      BuildContext context, {
        required ProcessController controller,
        bool isFromDeposite = false,
      }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _TransactionFilterContent(
        controller: controller,
        isFromDeposite: isFromDeposite,
      ),
    );
  }
}

class _TransactionFilterContent extends StatefulWidget {
  final ProcessController controller;
  final bool isFromDeposite;

  const _TransactionFilterContent({
    required this.controller,
    this.isFromDeposite = false,
  });

  @override
  State<_TransactionFilterContent> createState() =>
      _TransactionFilterContentState();
}

class _TransactionFilterContentState extends State<_TransactionFilterContent> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  GenericListModel? selectedStatus;
  GenericListModel? selectedMoneyTransferStatus;

  bool _isFilterActive = false;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.controller.selectedStatusFilter;
    selectedMoneyTransferStatus =
        widget.controller.selectedMoneyTransferStatusFilter;
    startDateController.text = widget.controller.startDateFilter ?? "";
    endDateController.text = widget.controller.endDateFilter ?? "";
    searchController.text = widget.controller.searchTextFilter ?? "";
  }

  void _updateFilterButtonState() {
    final fromDateFilled = startDateController.text.isNotEmpty;
    final toDateFilled = endDateController.text.isNotEmpty;
    final hasDropdowns =
        selectedStatus != null || selectedMoneyTransferStatus != null;
    final hasSearch = searchController.text.trim().isNotEmpty;

    setState(() {
      _isFilterActive = widget.isFromDeposite
          ? (fromDateFilled || toDateFilled || hasSearch)
          : (fromDateFilled || toDateFilled || hasDropdowns || hasSearch);
    });
  }

  void applyFilters() {
    widget.controller.startDateFilter =
    startDateController.text.isEmpty ? null : startDateController.text;
    widget.controller.endDateFilter =
    endDateController.text.isEmpty ? null : endDateController.text;
    widget.controller.searchTextFilter =
    searchController.text.isEmpty ? null : searchController.text;

    if (!widget.isFromDeposite) {
      widget.controller.selectedStatusFilter = selectedStatus;
      widget.controller.selectedMoneyTransferStatusFilter =
          selectedMoneyTransferStatus;
    } else {
      widget.controller.selectedStatusFilter = null;
      widget.controller.selectedMoneyTransferStatusFilter = null;
    }

    if (widget.isFromDeposite) {
      widget.controller.depositeFilterParams = ProcessFilterParams(
        page: 1,
        fromDate: widget.controller.startDateFilter,
        endDate: widget.controller.endDateFilter,
        search: widget.controller.searchTextFilter,
      );
      widget.controller.getDeposite();
    } else {
      widget.controller.withdrawFilterParams = ProcessFilterParams(
        page: 1,
        fromDate: widget.controller.startDateFilter,
        endDate: widget.controller.endDateFilter,
        search: widget.controller.searchTextFilter,
        status: widget.controller.selectedStatusFilter?.text,
        transferringStatus:
        widget.controller.selectedMoneyTransferStatusFilter?.name,
      );
      widget.controller.getWithdraw();
    }

    widget.controller.update();
    Get.back();
  }

  void clearFilters() {
    setState(() {
      startDateController.clear();
      endDateController.clear();
      searchController.clear();
      selectedStatus = null;
      selectedMoneyTransferStatus = null;
      _isFilterActive = false;
    });

    widget.controller.selectedStatusFilter = null;
    widget.controller.selectedMoneyTransferStatusFilter = null;
    widget.controller.startDateFilter = null;
    widget.controller.endDateFilter = null;
    widget.controller.searchTextFilter = null;
    widget.controller.getWithdraw();
    widget.controller.update();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

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
              /// --- Handle bar
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
                widget.isFromDeposite
                    ? 'filter_deposit_history'.tr
                    : 'filter_withdraw_history'.tr,
                style: typography.bodyStrongMedium.copyWith(
                  color: AppColors.content_primary,
                ),
              ),
              SizedBox(height: 24.h),

              /// --- Search Field
              AppTextField(
                controller: searchController,
                hintText: "search_in_results".tr,
                onChanged: (_) => _updateFilterButtonState(),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(IconsConstants.search),
                ),
              ),
              SizedBox(height: 20.h),

              /// --- Request Status (only for withdraw)
              if (!widget.isFromDeposite) ...[
                GenericNewDropdown<GenericListModel>(
                  title: "request_status".tr,
                  hint: "select_request_status".tr,
                  items: statusList,
                  selectedItem: selectedStatus,
                  itemLabel: (item) => item.name_ar ?? "",
                  onChanged: (value) {
                    setState(() => selectedStatus = value);
                    _updateFilterButtonState();
                  },
                ),
                SizedBox(height: 20.h),

                /// --- Money Transfer Status
                GenericNewDropdown<GenericListModel>(
                  title: "money_transfer_status".tr,
                  hint: "select_money_transfer_status".tr,
                  items: moneyTransferStatusList,
                  selectedItem: selectedMoneyTransferStatus,
                  itemLabel: (item) => item.name_ar ?? "",
                  onChanged: (value) {
                    setState(() => selectedMoneyTransferStatus = value);
                    _updateFilterButtonState();
                  },
                ),
                SizedBox(height: 20.h),
              ],

              /// --- Date Range Pickers
              Row(
                children: [
                  Expanded(
                    child: _datePickerField(
                      context: context,
                      controller: startDateController,
                      label: 'start_date'.tr,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _datePickerField(
                      context: context,
                      controller: endDateController,
                      label: 'end_date'.tr,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.h),

              /// --- Apply Filter Button
              SizedBox(
                width: ScreenUtil().screenWidth,
                height: 55.h,
                child: PrimaryTextButton(
                  onTap: _isFilterActive ? applyFilters : null,
                  customBackgroundColor: AppColors.primary,
                  appButtonSize: AppButtonSize.xxLarge,
                  label: Text(
                    'apply_filters'.tr,
                    style: typography.bodyLarge.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14.h),

              /// --- Cancel Button
              OutlinedButton(
                onPressed: clearFilters,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.border_default),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  minimumSize: Size(double.infinity, 48.h),
                ),
                child: Text(
                  'cancel'.tr,
                  style: typography.bodyLarge.copyWith(
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

  // --- Custom Date Picker Field
  Widget _datePickerField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
  }) {
    final typography = context.typography;
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
            style: typography.bodyLarge.copyWith(
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
                    style: typography.bodyMedium.copyWith(
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

/// --- Withdraw Status Options
final List<GenericListModel> statusList = [
  GenericListModel(id: 1, name_ar: 'بانتظار الموافقة', name: 'Pending Approval', text: "waiting_for_approval"),
  GenericListModel(id: 2, name_ar: 'تمت الموافقة', name: 'Approved', text: "approved"),
  GenericListModel(id: 3, name_ar: 'مرفوض', name: 'Rejected', text: "rejected"),
  GenericListModel(id: 4, name_ar: 'إلغاء', name: 'Cancelled', text: "canceled"),
];

/// --- Transfer Status Options
final List<GenericListModel> moneyTransferStatusList = [
  GenericListModel(id: 1, name_ar: 'قيد الانتظار', name: 'PENDING'),
  GenericListModel(id: 2, name_ar: 'مدفوع', name: 'PAID'),
  GenericListModel(id: 3, name_ar: 'مرتجع', name: 'RETURNED'),
];
