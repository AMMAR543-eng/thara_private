import 'package:equatable/equatable.dart';

class AddIndividualParams extends Equatable {
  final String citizenship;
  final String phoneNumber;
  final String nin;
  final String dob;

  const AddIndividualParams({
    required this.citizenship,
    required this.phoneNumber,
    required this.nin,
    required this.dob,
  });

  @override
  List<Object?> get props => [citizenship, phoneNumber, nin, dob];
}
