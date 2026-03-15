import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:thara/Data/Models/auth/about_us_model.dart';

import '../../../../index/index_main.dart';

class ContatcusVieWModel extends GetxController {
  /// **Static List of Contact Types**
  final List<Contatctus_TypesModel> contactTypes = [
    Contatctus_TypesModel(value: "inquiry", text: "استفسار"),
    Contatctus_TypesModel(value: "suggestion", text: "اقتراح"),
    Contatctus_TypesModel(value: "compliant", text: "شكوى"),
  ];

  InfoModel? infoModel;

  Map<String, InfoItem> get infoMap {
    final map = <String, InfoItem>{};
    for (var item in infoModel?.data ?? []) {
      if (item.key != null) map[item.key!] = item;
    }
    return map;
  }

  var message = "".obs;
  String? selectedType;

  ContatcusVieWModel();

  @override
  void onInit() {
    getAboutUseData();
    super.onInit();
  }

  void getAboutUseData() {
    // AuthenticationService().getAboutUs(
    //   voidCallBack: (data) {
    //     infoModel = data;
    //
    //     final systemDefinition = data.data?.firstWhere(
    //       (element) => element.key == 'system_definition',
    //       orElse: () => InfoItem(value: 'لا يوجد تعريف للنظام حاليًا'),
    //     );
    //
    //     update();
    //   },
    // );
  }

  /// **Set the selected contact type**
  void setSelectedType(String value) {
    selectedType = value;
    update();
  }

}

/// **Model for Contact Types**
class Contatctus_TypesModel {
  final String value;
  final String text;

  Contatctus_TypesModel({required this.value, required this.text});

  factory Contatctus_TypesModel.fromJson(Map<String, dynamic> json) {
    return Contatctus_TypesModel(text: json['text'], value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {'value': value, 'text': text};
  }
}
