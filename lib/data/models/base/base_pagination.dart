import '../../../index/index_main.dart';

class Meta extends MetaEntity {
  const Meta({
    int? currentPage,
    int? from,
    int? lastPage,
    int? perPage,
    int? to,
    int? total,
  }) : super(
          currentPage: currentPage,
          from: from,
          lastPage: lastPage,
          perPage: perPage,
          to: to,
          total: total,
        );

  // Factory method to create a MetaEntity from a Map
  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'] ?? 0,
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      perPage: json['per_page'] ?? 0,
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  // Method to convert a MetaEntity to a Map
  @override
  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}
