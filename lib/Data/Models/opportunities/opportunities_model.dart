import 'package:thara/Domain/entity/opportunities/get_opportunities_entity.dart';
import '../pagination/pagination.dart';
import 'opportunities_Items_model.dart';

class OpportunitiesResponse extends GetOpportunitiesEntity {
  const OpportunitiesResponse({
    final List<OpportunitiesItemsResponse?>? opportunitiesItems,
    final Pagination? opportunitiesMeta,
    final int? customStatusCode,
    final String? message,
    final bool? debug,
    final String? env,
  }) : super(
         opportunitiesMeta: opportunitiesMeta,
         opportunitiesItems: opportunitiesItems,
         customStatusCode: customStatusCode,
         message: message,
         debug: debug,
         env: env,
       );

  factory OpportunitiesResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    final List<dynamic>? rawList = data?['items'] as List<dynamic>?;
    final List<OpportunitiesItemsResponse> itemsList = rawList != null
        ? rawList
              .map(
                (i) => OpportunitiesItemsResponse.fromJson(
                  i as Map<String, dynamic>,
                ),
              )
              .toList()
        : [];

    return OpportunitiesResponse(
      opportunitiesItems: itemsList,
      opportunitiesMeta: data?['meta'] != null
          ? Pagination.fromJson(data!['meta'] as Map<String, dynamic>)
          : null,
      customStatusCode: json['customStatusCode'] as int?,
      message: json['message'] as String?,
      debug: json['debug'] as bool?,
      env: json['env'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'items': opportunitiesItems?.map((e) {
          if (e is OpportunitiesItemsResponse) {
            return e.toJson();
          } else {
            return {}; // or throw/ignore depending on your needs
          }
        }).toList(),
        'meta': opportunitiesMeta?.toJson(),
      },
      'customStatusCode': customStatusCode,
      'message': message,
      'debug': debug,
      'env': env,
    };
  }
}
