import 'package:equatable/equatable.dart';

class OtpParams extends Equatable {
  final String code;
  String? url;
  String? withdraw_id;

  OtpParams({required this.code, this.url, this.withdraw_id});

  @override
  List<Object?> get props => [code];
}
