import 'package:thara/Presentation/screens/dashboard/pagination_opportunity.dart';

import '../../../../index/index_main.dart';

class OpportunitiesController extends GetxController {
  GetOpportunitiesEntity? opportunities;
  TradeAccountEntity? tradeAccountEntity;
  BankAccountDataEntity? bankAccountDataEntity;
  OpportunityParameter? param = OpportunityParameter(
    page: 1,
    status: subscription_status.available,
  );
  PaginationHandleClass paginationHandleClass = PaginationHandleClass();
  var tab_index = 0;

  @override
  void onInit() {
    paginationHandleClass.loadInitialData(
      onDataLoaded: (model) {
        opportunities = model;
        update();
      },
    );

    super.onInit();
  }

  void tabsActions(int index) {
    if (index == 0) {
      param = OpportunityParameter(
        page: 1,
        status: subscription_status.available,
      );
      tab_index = 0;
    } else if (index == 1) {
      param = OpportunityParameter(
        page: 1,
        status: subscription_status.upcoming,
      );
      tab_index = 1;
    } else {
      param = OpportunityParameter(
        page: 1,
        status: subscription_status.completed,
      );
      tab_index = 2;
    }
    print("parammm is ${param?.toJson()}");
    paginationHandleClass.loadInitialData(
      onDataLoaded: (model) {
        opportunities = model;
        update();
      },
    );
    update();
  }

  void getTradeAccountData() {
    ProcessService().getTradeAccount(
      voidCallBack: (data) {
        tradeAccountEntity = data;
        update();
      },
    );
  }


  getOpportunitiesData() {
    OpportunitiesService().getOpportunities(
      voidCallBack: (data) {
        opportunities = data;
        update();
      },
    );
  }

  getBankAccounts() {
    ProcessService().getBankAccounts(
      voidCallBack: (data) {
        bankAccountDataEntity = data;

        update();
      },
      processParam: ProcessFilterParams(),
    );
  }
}
