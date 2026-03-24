import '../../../../index/index_main.dart';

class NotificationViewModel extends GetxController {
  // List<NotificationEntity>? notificationList;
  // PaginationHandler paginationHandler_Notification = PaginationHandler();
  //
  // NotificationViewModel();
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   notification_data();
  //   paginationHandler_Notification.addItems(() {
  //     notification_data();
  //   });
  // }
  //
  // String timestampToDate(int timestamp) {
  //   var format = DateFormat.yM("en_US").add_jm();
  //   var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  //   //  String dateTime = "${date.month}:${date.day}:${date.day}";
  //   return format.format(date);
  // }
  //
  // Future<void> notification_data() async {
  //   if (paginationHandler_Notification.pageNum <=
  //       paginationHandler_Notification.totalPage) {
  //     if (paginationHandler_Notification.pageNum == 1) {
  //       notificationList?.clear();
  //     }
  //     Loader.show();
  //     PaginationEntity paginationEntity = PaginationEntity(
  //       size: Strings.index_pagination,
  //       page: paginationHandler_Notification.pageNum,
  //     );
  //     Notification_UseCase notification_useCase =
  //         Get.isRegistered<Notification_UseCase>()
  //             ? Get.find<Notification_UseCase>()
  //             : Get.put(Notification_UseCase(Get.find()));
  //     NotificationWithPagination_Entity notificationWithPagination_Entity =
  //         await notification_useCase.call(paginationEntity);
  //
  //     Loader.dismiss();
  //
  //     paginationHandler_Notification.pageNum == 1
  //         ? notificationList =
  //             notificationWithPagination_Entity.notificationData
  //         : notificationList?.addAll(
  //             notificationWithPagination_Entity.notificationData ?? []);
  //
  //     paginationHandler_Notification.productDomain =
  //         notificationWithPagination_Entity.paginationEntityDomain ??
  //             PaginationEntityDomain();
  //
  //     paginationHandler_Notification.totalPage =
  //         paginationHandler_Notification.productDomain?.lastPage ?? 0;
  //
  //     update();
  //   } else {
  //   }
  // }
}
