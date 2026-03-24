import 'package:thara/index/index_main.dart';

class OpportunityDetailsController extends GetxController {
  OpportunityDetailsEntity? opportunityDetailsEntity;
  OpportunitiesItemsEntity? opportunitiesItemsEntity;

  void getOpportunityDetails(String id) {
    OpportunitiesService().getOpportunityDetails(
      oppo_id: id,
      voidCallBack: (data) {
        opportunityDetailsEntity = data;
        opportunitiesItemsEntity = data.opportunitiesItems;
        update();
      },
    );
  }

  void reloadWithNewId(ScrollController scrollController, String newId) {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    getOpportunityDetails(newId);
  }

  subscribeToLoan(String oppoId, int sharePrice, String value) {
    int amount = int.tryParse(value) ?? 0;
    OpportunitiesService().subscribeToLoan(
      param: InvestSubscribeParam(oppoId, (amount / sharePrice).toInt()),
      voidCallBack: (data) {
        getOpportunityDetails(oppoId);
        updateHome();
        Loader.showSuccess(data.message ?? "");
      },
    );
  }

  updateHome() {
    DashboardController dashboardController = initUseCase(
      () => DashboardController(),
    );
    dashboardController.getAvailableOpportunities();
    dashboardController.update();
  }

  cancelSubscription(String opportunityId) {
    OpportunitiesService().cancelSubscription(
      opportunityId: opportunityId,
      voidCallBack: (data) {
        getOpportunityDetails(opportunityId);
        updateHome();
        Loader.showSuccess(data.message ?? "");
      },
    );
  }
}

String normalizeUrl(String url) {
  final uriParts = url.split('://');
  if (uriParts.length != 2) return url;

  final protocol = uriParts[0];
  final path = uriParts[1].replaceAll(RegExp(r'\/{2,}'), '/');
  return '$protocol://$path';
}
