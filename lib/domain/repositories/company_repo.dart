import '../entities/company.dart';

abstract class CompanyRepo {
  Future<bool> checkCompany({required String company});

  Future<bool> registerCompany({required String company});

  Future<Company> getCompany({required String company});

  Future<List<String>> updateCompany({required Company newCompany});
}
