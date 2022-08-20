import 'package:equatable/equatable.dart';

class ContactInfo extends Equatable {
  final List<String> phones;
  final List<String> emails;

  const ContactInfo({
    this.phones = const [],
    this.emails = const [],
  });

  @override
  List<Object?> get props => [
        phones,
        emails,
      ];
}
