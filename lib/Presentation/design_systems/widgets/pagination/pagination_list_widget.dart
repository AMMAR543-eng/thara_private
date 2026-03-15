import '../../../../index/index_main.dart';

class PaginatedListView<T> extends StatelessWidget {
  final PaginationController<T, dynamic> controller;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  final Widget? paginationLoader;
  final Widget? emptyStateWidget;
  final Widget? shimmerLoader;

  const PaginatedListView({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    this.paginationLoader,
    this.emptyStateWidget,
    this.shimmerLoader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isEmpty = controller.items.isEmpty;
      final isLoading = controller.isLoading;
      final hasMore = controller.hasMoreData;
      final isLoadingMore = controller.isLoadingMore.value;

      if (isLoading && isEmpty) {
        return shimmerLoader ?? const SizedBox.shrink();
      }

      final showEmpty = isEmpty && !isLoading;
      final itemCount =
          controller.items.length + (isLoadingMore && hasMore ? 1 : 0);

      if (showEmpty) {
        return emptyStateWidget ??
            Center(
              child: Padding(
                padding: const EdgeInsets.all(100.0),
                child: Text(
                  "no_data".tr,
                  style: context.typography.headerXLarge.copyWith(
                    color: AppColors.action_primary_normal,
                  ),
                ),
              ),
            );
      }

      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent &&
              !isLoadingMore &&
              hasMore) {
            controller.loadMoreData();
          }
          return false;
        },
        child: ListView.builder(
          controller: controller.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            if (index < controller.items.length) {
              return itemBuilder(context, controller.items[index], index);
            }

            if (isLoadingMore && hasMore) {
              return paginationLoader ??
                  const Center(child: CircularProgressIndicator());
            }

            return const SizedBox.shrink();
          },
        ),
      );
    });
  }
}
