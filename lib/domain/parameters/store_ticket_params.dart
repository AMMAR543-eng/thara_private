import 'package:equatable/equatable.dart';

class StoreTicketParams extends Equatable {
  final String name;
  final String phone;
  final String type;
  final String message;

  const StoreTicketParams({
    required this.name,
    required this.phone,
    required this.type,
    required this.message,
  });

  @override
  List<Object?> get props => [name, phone, type, message];
}
