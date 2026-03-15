import 'package:thara/Data/Models/auth/about_us_model.dart';
import '../../../index/index_main.dart';

class SettingsController extends GetxController {
  GenericListModel? selectedTicketType;
  InfoModel? infoModel;

  List<GenericListModel>? listTicketTypes = [
    GenericListModel(id: 1, name_ar: 'inquiry', name: 'سؤال'),
    GenericListModel(id: 2, name_ar: 'complaint', name: 'شكوى'),
  ];

  Map<String, InfoItem> get infoMap {
    final map = <String, InfoItem>{};
    for (var item in infoModel?.data ?? []) {
      if (item.key != null) map[item.key!] = item;
    }
    return map;
  }

  void onTicketSelected(GenericListModel? ticketType) {
    selectedTicketType = ticketType;
    update();
  }

  storeTicketApi(String name, String phone, String type, String message) {
    SettingsService().storeTicket(
      name: name,
      phone: phone,
      type: type,
      message: message,
      voidCallBack: (data) async {
        if (data.customStatusCode == 200) {
          Get.back();
          Loader.showSuccess("تم ارسال التذكرة بنجاح");
        }
      },
    );
  }

  changePasswordApi(
    String oldPassword,
    String password,
    String passwordConfirm,
  ) {
    SettingsService().changePassword(
      oldPassword: oldPassword,
      password: password,
      passwordConfirm: passwordConfirm,
      voidCallBack: (data) {
        Get.back();
        Loader.showSuccess("تم تغيير كلمة المرور بنجاح");
      },
    );
  }
}
