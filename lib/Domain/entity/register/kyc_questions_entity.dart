import 'package:equatable/equatable.dart';

import 'kyc_item_entity.dart';

class KycQuestionsEntity extends Equatable {
  final List<KycItemEntity>? questions;

  const KycQuestionsEntity({this.questions});

  @override
  List<Object?> get props => [questions];
}
