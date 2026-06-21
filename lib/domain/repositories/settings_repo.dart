import 'package:dartz/dartz.dart';
import '../../index/index_main.dart';

abstract class SettingsRepository {
  // ---------------------------------------------------------------------------
  // 🔐 Change Password
  // ---------------------------------------------------------------------------
  Future<Either<AppError, BaseEntity>> changePasswordDomain(
    String oldPassword,
    String password,
    String passwordConfirm,
  );

  // ---------------------------------------------------------------------------
  // ✉️ Change Email
  // ---------------------------------------------------------------------------
  Future<Either<AppError, BaseEntity>> changeEmailRequestOtpDomain();

  Future<Either<AppError, BaseEntity>> changeEmailSubmitDomain(
    String email,
    String otp,
  );

  Future<Either<AppError, BaseEntity>> verifyNewEmailDomain(
    String email,
    String otp,
  );

  // ---------------------------------------------------------------------------
  // 📱 Change Phone
  // ---------------------------------------------------------------------------
  Future<Either<AppError, BaseEntity>> changePhoneRequestOtpDomain();

  Future<Either<AppError, BaseEntity>> changePhoneSubmitDomain(
    String phone,
    String otp,
  );

  Future<Either<AppError, BaseEntity>> verifyNewPhoneDomain(
    String phone,
    String otp,
  );

  // ---------------------------------------------------------------------------
  // 🧾 Support Ticket
  // ---------------------------------------------------------------------------
  Future<Either<AppError, BaseEntity>> storeTicketDomain(
    String name,
    String phone,
    String type,
    String message,
  );

  // ---------------------------------------------------------------------------
  // 🗑️ Delete My Profile
  // ---------------------------------------------------------------------------
  Future<Either<AppError, BaseEntity>> deleteMyProfileDomain(
      Map<String, dynamic> data);

  // ---------------------------------------------------------------------------
  // 📰 Articles
  // ---------------------------------------------------------------------------
  /// 🔍 Fetch list of articles
  Future<Either<AppError, ArticleModelResponse>> getArticles(
    Map<String, dynamic> data,
  );

  /// 📄 Fetch single article details
  Future<Either<AppError, ArticleDetailsModelResponse>> getArticleDetails(
    Map<String, dynamic> data,
    String key,
  );

  // ---------------------------------------------------------------------------
  // ❓ FAQs
  // ---------------------------------------------------------------------------
  Future<Either<AppError, FaqsData>> getFaqData();

  // ---------------------------------------------------------------------------
  // 📊 Financial Statements
  // ---------------------------------------------------------------------------
  Future<Either<AppError, FinancialStatementsData>>
      getFinancialStatementsData();
}
