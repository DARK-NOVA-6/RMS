import '../../../injection_container.dart';
import '../../entities/company.dart';
import '../../repositories/company_repo.dart';

class GetCompany {
  final CompanyRepo companyRepo;

  GetCompany() : companyRepo = sl();

  Future<Company> call({required String company}) =>
      companyRepo.getCompany(company: company);
}
