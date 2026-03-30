class InfoModel {
  final List<InfoItem>? data;
  final String? message;
  final int? status;

  InfoModel({this.data, this.message, this.status});

  factory InfoModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return InfoModel();

    return InfoModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => InfoItem.fromJson(item))
          .toList(),
      message: json['message'] as String?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((item) => item.toJson()).toList(),
      'message': message,
      'status': status,
    };
  }
}

class InfoItem {
  final String? key;
  final String? value;

  InfoItem({this.key, this.value});

  factory InfoItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) return InfoItem();

    return InfoItem(
      key: json['key'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'key': key, 'value': value};
  }
}
