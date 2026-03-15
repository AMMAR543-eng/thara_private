// ignore_for_file: non_constant_identifier_names


import '../../index/index_main.dart';

class NavigationGet {
  void route_name(String name, {Map<String, dynamic>? data}) {
    Get.toNamed(name, arguments: data);
  }

  Future<dynamic> route_nameWithDataBack(String name,
      {Map<String, dynamic>? data}) async {
    final result = await Get.toNamed(name, arguments: data);
    return result;
  }

  void route_offall(String name) {
    Get.offAllNamed(name);
  }

  void route_off(String name) {
    Get.offNamed(name);
  }

  void dismiss({bool withdata = false}) {
    withdata ? Get.back(result: "data") : Get.back();
  }
}
