import 'package:equatable/equatable.dart';

import 'contact_info.dart';

class Company extends Equatable {
  final String id;
  final String name;
  final DateTime establishmentDate;
  final String summary;
  final Map<String, List<ContactInfo>> contactAddressInfo;

  const Company({
    required this.id,
    required this.name,
    required this.establishmentDate,
    required this.contactAddressInfo,
    required this.summary,
  });

  @override
  List<Object?> get props =>
      [
        id,
        name,
        establishmentDate,
        contactAddressInfo,
        summary,
      ];
}
