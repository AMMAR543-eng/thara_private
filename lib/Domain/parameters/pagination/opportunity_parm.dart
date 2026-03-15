import '../../../index/index_main.dart';

enum subscription_status { available, upcoming, completed }

class OpportunityParameter {
  final int? page;
  final subscription_status? status;

  OpportunityParameter({this.page, this.status});

  /// Convert to JSON, including only keys with non-null and non-empty data
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (page != null) data['page'] = page;

    // Map enum to string if status is not null
    if (status != null) {
      data['subscription_status'] = _mapStatusToString(status!);
    }

    return data;
  }

  /// Helper to convert enum to API string
  String _mapStatusToString(subscription_status status) {
    switch (status) {
      case subscription_status.available:
        return 'available';
      case subscription_status.completed:
        return 'completed';
      case subscription_status.upcoming:
        return 'upcoming';
      default:
        return '';
    }
  }

  /// Copy with support
  OpportunityParameter copyWith({int? page, subscription_status? status}) {
    return OpportunityParameter(
      page: page ?? this.page,
      status: status ?? this.status,
    );
  }
}
