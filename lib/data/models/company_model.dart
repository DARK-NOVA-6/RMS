import '../../domain/entities/company.dart';

class CompanyModel extends Company {
  const CompanyModel({
    required super.adminId,
    required super.name,
    required super.address,
    required super.creationDate,
    required super.phones,
    required super.emails,
  });

  static Company? fromSnapshot({
    required Map<String, dynamic>? documentSnapshot,
  }) {
    if (documentSnapshot == null) return null;
    return Company(
      adminId: documentSnapshot['admin-id'],
      name: documentSnapshot['company-name'],
      address: documentSnapshot['address'],
      creationDate: documentSnapshot['creation-date'],
      phones: const [],
      emails: const [],
    );
  }

  static Map<String, dynamic> toSnapshot(Company company) {
    return {
      'admin-id': company.adminId,
      'company-name': company.name,
      'address': company.address,
      'creation-date': company.creationDate,
      'contact-info': {},
    };
  }
}
