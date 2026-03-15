
List<T?> handleResponse<T>(
    dynamic response, T Function(Map<String, dynamic>) fromJson) {
  final dataresponse = response;

  List<T?> itemList = [];
  if (dataresponse is List) {
    print("doannnne");
    final List<dynamic> responseList = dataresponse;
    itemList = responseList
        .map((dynamic item) {
          if (item != null) {
            return fromJson(item);
          }
        })
        .where((merchant) => merchant != null)
        .toList();
  } else if (dataresponse is Map) {
    print("doannnne 222");
    // Handle the case where the response is a Map
    final Map<dynamic, dynamic> responseMap = dataresponse;
    responseMap.forEach((key, itemData) {
      // Parse each entry in the map using the provided fromJson method
      itemList.add(fromJson(itemData));
    });
  }

  return itemList;
}
