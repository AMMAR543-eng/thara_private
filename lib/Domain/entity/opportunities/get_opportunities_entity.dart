import 'package:equatable/equatable.dart';

import '../../../Data/Models/pagination/pagination.dart';
import 'opportunities_item_entity.dart';

class GetOpportunitiesEntity extends Equatable {
  final List<OpportunitiesItemsEntity?>? opportunitiesItems;
  final Pagination? opportunitiesMeta;
  final int? customStatusCode;
  final String? message;
  final bool? debug;
  final String? env;

  const GetOpportunitiesEntity({
    this.opportunitiesItems,
    this.customStatusCode,
    this.message,
    this.debug,
    this.env,
    this.opportunitiesMeta,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    opportunitiesItems,
    customStatusCode,
    message,
    debug,
    env,
    opportunitiesMeta,
  ];
}
