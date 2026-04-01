class ProcessFilterParams {
  final String? fromDate; // 🔹 بداية النطاق الزمني
  final String? endDate; // 🔹 نهاية النطاق الزمني
  final String? status; // 🔹 حالة الطلب
  final String? transferringStatus; // 🔹 حالة تحويل الأموال
  final String? search; // 🔹 نص البحث
  final int? page; // 🔹 رقم الصفحة

  ProcessFilterParams({
    this.fromDate,
    this.endDate,
    this.page,
    this.status,
    this.transferringStatus,
    this.search,
  });

  /// ✅ Convert to JSON (for API requests)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (fromDate != null && fromDate!.isNotEmpty) {
      data['fromDate'] = fromDate;
    }
    if (endDate != null && endDate!.isNotEmpty) {
      data['endDate'] = endDate;
    }
    if (status != null && status!.isNotEmpty) {
      data['status'] = status;
    }
    if (transferringStatus != null && transferringStatus!.isNotEmpty) {
      data['transferringStatus'] = transferringStatus;
    }
    if (search != null && search!.isNotEmpty) {
      data['search'] = search;
    }
    if (page != null) {
      data['page'] = page;
    }
    return data;
  }

  /// ✅ Create a modified copy
  ProcessFilterParams copyWith({
    String? fromDate,
    String? endDate,
    int? page,
    String? status,
    String? transferringStatus,
    String? search,
  }) {
    return ProcessFilterParams(
      fromDate: fromDate ?? this.fromDate,
      endDate: endDate ?? this.endDate,
      page: page ?? this.page,
      status: status ?? this.status,
      transferringStatus: transferringStatus ?? this.transferringStatus,
      search: search ?? this.search,
    );
  }
}
