import 'package:equatable/equatable.dart';

// Extend Equatable for automatic equality comparison
class MetaEntity extends Equatable {
  final int? currentPage;
  final int? from;
  final int? lastPage;
  final int? perPage;
  final int? to;
  final int? total;

  const MetaEntity({
    this.currentPage,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  @override
  List<Object?> get props => [currentPage, from, lastPage, perPage, to, total];

  factory MetaEntity.fromJson(Map<String, dynamic> json) {
    return MetaEntity(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }

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
