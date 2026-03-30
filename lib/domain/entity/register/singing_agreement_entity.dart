import 'package:equatable/equatable.dart';

import '../../../index/index_main.dart';

class SingingDetailsEntity extends Equatable {
  final String? investAgreement;

  const SingingDetailsEntity({this.investAgreement});

  @override
  List<Object?> get props => [investAgreement];
}
