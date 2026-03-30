

import '../../../index/index_main.dart';

class ProcessView extends StatefulWidget {
  const ProcessView({super.key});

  @override
  State<ProcessView> createState() => _ProcessViewState();
}

class _ProcessViewState extends State<ProcessView> {
  final ProcessController controller = Get.put(ProcessController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProcessController>(
      builder: (controller) {
        final isGuest =
            LoginResponseModel().getTokenData()?.data?.accessToken == null;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: AppColors.background_neutral_surface,
            appBar: ProcessAppBar(
              title: "transactions".tr,
              controller: controller,
              selectedTab: controller.tab_index,
            ),
            body: Stack(
              children: [
                /// 🔹 Background
                Positioned(
                  left: -150,
                  top: 20,
                  child: Image.asset(
                    Images.home_pattern,
                    width: ScreenUtil().screenWidth,
                    height: 400.h,
                    fit: BoxFit.fill,
                    color: AppColors.focus_input_text.withValues(alpha: 0.07),
                  ),
                ),

                /// 🔹 Main content
                SafeArea(
                  child: isGuest
                      ? const GuestUserDialogWidget()
                      : _buildContent(context, controller),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 🔹 Build Content for Logged-in User
  Widget _buildContent(BuildContext context, ProcessController controller) {
    final bool isDepositTab = controller.tab_index == 0;
    final isLoading = isDepositTab
        ? controller.depositeDataEntity == null
        : controller.withdrawDataEntity == null;

    final hasData = isDepositTab
        ? (controller.depositeDataEntity?.items?.isNotEmpty ?? false)
        : (controller.withdrawDataEntity?.items?.isNotEmpty ?? false);

    if (isLoading) {
      return const TransactionListShimmerWidget();
    }

    /// ✅ Build Data List
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'investment_operations'.tr,
                  style: context.typography.headerXLarge.copyWith(
                    color: AppColors.content_brand_secondary,
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.showFilterBottomSheet(context),
                  child: Row(
                    children: [
                      Text(
                        "filter".tr,
                        style: context.typography.bodyMedium.copyWith(
                          color: AppColors.action_primary_normal,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      SvgPicture.asset(
                        IconsConstants.search,
                        width: 20.w,
                        height: 20.w,
                        colorFilter:  ColorFilter.mode(
                          AppColors.content_primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🔹 Active Filters
          _buildActiveFilters(context, controller),
          SizedBox(height: 10.h),

          /// 🔹 Data List
          Expanded(
            child: hasData
                ? ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                isDepositTab
                    ? DepositesListViewWidget(controller: controller)
                    : WithdrawListViewWidget(controller: controller),
              ],
            )
                : Center(
              child: Padding(
                padding: EdgeInsets.only(top: 80.h),
                child: PlaceholderImage(
                  image: Images.no_data,
                  messege: isDepositTab
                      ? "no_deposit_operations".tr
                      : "no_withdraw_operations".tr,
                  isAsset: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// --- Active Filters Chips Section
  Widget _buildActiveFilters(
      BuildContext context,
      ProcessController controller,
      ) {
    final filters = <Widget>[];

    // Only show for Withdraw tab
    if (controller.tab_index == 1) {
      if (controller.selectedStatusFilter != null) {
        filters.add(
          _buildChip(
            context,
            label:
            "${'request_status'.tr}: ${controller.selectedStatusFilter?.name_ar ?? controller.selectedStatusFilter?.name ?? ""}",
            onRemove: () {
              controller.selectedStatusFilter = null;
              controller.getWithdraw();
              controller.update();
            },
          ),
        );
      }

      if (controller.selectedMoneyTransferStatusFilter != null) {
        filters.add(
          _buildChip(
            context,
            label:
            "${'money_transfer_status'.tr}: ${controller.selectedMoneyTransferStatusFilter?.name_ar ?? controller.selectedMoneyTransferStatusFilter?.name ?? ""}",
            onRemove: () {
              controller.selectedMoneyTransferStatusFilter = null;
              controller.getWithdraw();
              controller.update();
            },
          ),
        );
      }
    }

    if (controller.startDateFilter != null &&
        controller.endDateFilter != null) {
      filters.add(
        _buildChip(
          context,
          label:
          "${'date_range'.tr}: ${controller.startDateFilter} ${'until'.tr} ${controller.endDateFilter}",
          onRemove: () {
            controller.startDateFilter = null;
            controller.endDateFilter = null;
            controller.getWithdraw();
            controller.getDeposite();
            controller.update();
          },
        ),
      );
    }

    if (controller.searchTextFilter != null &&
        controller.searchTextFilter!.isNotEmpty) {
      filters.add(
        _buildChip(
          context,
          label: "${'search'.tr}: ${controller.searchTextFilter}",
          onRemove: () {
            controller.searchTextFilter = null;
            controller.getWithdraw();
            controller.getDeposite();
            controller.update();
          },
        ),
      );
    }

    if (filters.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < filters.length; i++) ...[
              filters[i],
              if (i != filters.length - 1) SizedBox(width: 8.w),
            ],
          ],
        ),
      ),
    );
  }

  /// --- Single Filter Chip
  Widget _buildChip(
      BuildContext context, {
        required String label,
        required VoidCallback onRemove,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.border_default),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: context.typography.bodyMedium.copyWith(
              color: AppColors.content_primary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 16,
              color: AppColors.content_secondary,
            ),
          ),
        ],
      ),
    );
  }
}
