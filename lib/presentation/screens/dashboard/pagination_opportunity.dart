import '../../../../index/index_main.dart';

class PaginationHandleClass extends PaginationController<
    OpportunitiesItemsEntity?, GetOpportunitiesEntity> {
  PaginationHandleClass()
      : super(
          fetchData: (page) async {
            final completer = Completer<GetOpportunitiesEntity>();

            // ✅ Get the EXISTING controller instead of creating a new one
            final controller = initUseCase(() => OpportunitiesController());

            final params = controller.param?.copyWith(page: page);

            if (params != null) {
              OpportunitiesService().getOpportunities(
                param: params,
                voidCallBack: completer.complete,
              );
            } else {
              completer.complete(
                const GetOpportunitiesEntity(opportunitiesItems: []),
              );
            }

            return completer.future;
          },
          extractData: (response) => response.opportunitiesItems ?? [],
        );
}
