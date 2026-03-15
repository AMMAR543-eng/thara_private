import 'package:equatable/equatable.dart';

class AddCompanyParams extends Equatable {
  final String citizenship;
  final String phoneNumber;
  final String nin;
  final String dob;
  final String name;
  final String fieldOfBusiness;
  final String crn;
  final String unifiedNumber;

  const AddCompanyParams({
    required this.citizenship,
    required this.phoneNumber,
    required this.nin,
    required this.dob,
    required this.name,
    required this.fieldOfBusiness,
    required this.crn,
    required this.unifiedNumber,
  });

  @override
  List<Object?> get props => [
    citizenship,
    phoneNumber,
    nin,
    dob,
    name,
    fieldOfBusiness,
    crn,
    unifiedNumber,
  ];
}
