import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class GetInvestmentsUseCase
    extends
        Use_Case<
          Either<AppError, InvestmentTransactionDataEntity>,
          InvestmentFilterParams
        > {
  final OpportunitiesRepository _opportunitiesRepository;

  // Constructor
  GetInvestmentsUseCase(this._opportunitiesRepository);

  @override
  Future<Either<AppError, InvestmentTransactionDataEntity>> call(
    InvestmentFilterParams params,
  ) async {
    return await _opportunitiesRepository.getInvestments(params.toQueryMap());
  }
}

/// 🔹 Filter parameters for investment subscriptions API
class InvestmentFilterParams {
  final int? page;
  final String? fromDate; // e.g., "2025-10-10"
  final String? endDate; // e.g., "2025-10-29"
  final String? status; // e.g., "active", "closed", etc.
  final String? query; // e.g., search text

  InvestmentFilterParams({
    this.page = 1,
    this.fromDate,
    this.endDate,
    this.status,
    this.query,
  });

  /// ✅ Convert to query map (for Dio or http.get)
  Map<String, dynamic> toQueryMap() {
    final Map<String, dynamic> map = {'page': page};

    if (fromDate != null && fromDate!.isNotEmpty) {
      map['fromDate'] = fromDate;
    }
    if (endDate != null && endDate!.isNotEmpty) {
      map['endDate'] = endDate;
    }
    if (status != null && status!.isNotEmpty) {
      map['status'] = status;
    }
    if (query != null && query!.isNotEmpty) {
      map['q'] = query;
    }

    return map;
  }

  /// ✅ Build full query string for manual GET URLs
  String toQueryString() {
    final map = toQueryMap();
    return map.entries
        .map(
          (e) =>
              "${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}",
        )
        .join('&');
  }

  /// ✅ Build full API endpoint with base URL
  String buildEndpoint(String baseUrl) {
    final query = toQueryString();
    return "$baseUrl?$query";
  }
}
