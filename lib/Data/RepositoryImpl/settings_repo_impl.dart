import 'package:dartz/dartz.dart';
import '../../index/index_main.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  late final SettingsRemoteDataSourceRepo _settingsRemoteDataSourceRepo;

  SettingsRepositoryImpl(this._settingsRemoteDataSourceRepo);

  // ---------------------------------------------------------------------------
  // 🔐 Change Password
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppError, BaseEntity>> changePasswordDomain(
      String oldPassword,
      String password,
      String passwordConfirm,
      ) async {
    final result = await _settingsRemoteDataSourceRepo.changePassword(
      oldPassword,
      password,
      passwordConfirm,
    );

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  // ---------------------------------------------------------------------------
  // ✉️ Email
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppError, BaseEntity>> changeEmailDomain(String email) async {
    final result = await _settingsRemoteDataSourceRepo.changeEmail(email);

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> verifyNewEmailDomain(
      String email,
      String otp,
      ) async {
    final result = await _settingsRemoteDataSourceRepo.verifyNewEmail(
      email,
      otp,
    );

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  // ---------------------------------------------------------------------------
  // 📱 Phone
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppError, BaseEntity>> changePhoneDomain(String phone) async {
    final result = await _settingsRemoteDataSourceRepo.changePhone(phone);

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> verifyNewPhoneDomain(
      String phone,
      String otp,
      ) async {
    final result = await _settingsRemoteDataSourceRepo.verifyNewPhone(
      phone,
      otp,
    );

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  // ---------------------------------------------------------------------------
  // 🎟️ Support Ticket
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppError, BaseEntity>> storeTicketDomain(
      String name,
      String phone,
      String type,
      String message,
      ) async {
    final result = await _settingsRemoteDataSourceRepo.storeTicket(
      name,
      phone,
      type,
      message,
    );

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  // ---------------------------------------------------------------------------
  // 🗑️ Delete My Profile
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppError, BaseEntity>> deleteMyProfileDomain(Map<String, dynamic> data) async {
    final result = await _settingsRemoteDataSourceRepo.deleteMyProfile(data);

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  // ---------------------------------------------------------------------------
  // 📰 Articles
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppError, ArticleModelResponse>> getArticles(
      Map<String, dynamic> data,
      ) async {
    final result = await _settingsRemoteDataSourceRepo.articles(data);

    return result is Success<ArticleModelResponse>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, ArticleDetailsModelResponse>> getArticleDetails(
      Map<String, dynamic> data,
      String key,
      ) async {
    final result = await _settingsRemoteDataSourceRepo.articles_details(
      data,
      key,
    );

    return result is Success<ArticleDetailsModelResponse>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  // ---------------------------------------------------------------------------
  // ❓ FAQs
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppError, FaqsData>> getFaqData() async {
    final result = await _settingsRemoteDataSourceRepo.faqData();

    return result is Success<FaqsData>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  // ---------------------------------------------------------------------------
  // 📊 Financial Statements
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppError, FinancialStatementsData>>
  getFinancialStatementsData() async {
    final result = await _settingsRemoteDataSourceRepo.financialStatmentsData();

    return result is Success<FinancialStatementsData>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }
}
