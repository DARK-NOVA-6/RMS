import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String adminId;
  final String name;
  final String address;
  final Timestamp creationDate;
  final List<String> phones;
  final List<String> emails;

  const Company({
    required this.adminId,
    required this.name,
    required this.address,
    required this.creationDate,
    required this.phones,
    required this.emails,
  });

  @override
  List<Object?> get props => [
        adminId,
        name,
        address,
        creationDate,
        phones,
        emails,
      ];
}
