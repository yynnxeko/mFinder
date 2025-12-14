import 'package:dartz/dartz.dart';
import '../error/failures.dart';
import 'constants.dart';

class InputValidator {  static Either<Failure, String> validateUrl(String url) {
    if (url.trim().isEmpty) {
      return const Left(ValidationFailure(ValidationMessages.emptyUrl));
    }
    
    // Basic URL validation
    final urlRegex = RegExp(r'^https?://');
    if (!urlRegex.hasMatch(url.trim())) {
      return const Left(ValidationFailure(ValidationMessages.invalidUrl));
    }
    
    return Right(url.trim());
  }
  
  static Either<Failure, String> validateFacebookUrl(String url) {
    final basicValidation = validateUrl(url);
    if (basicValidation.isLeft()) return basicValidation;
    
    // Check if it's a Facebook URL
    if (!url.toLowerCase().contains('facebook.com') && !url.toLowerCase().contains('fb.com')) {
      return const Left(ValidationFailure(ValidationMessages.invalidFacebookUrl));
    }
    
    return Right(url.trim());
  }
    static Either<Failure, String> validateTiktokUrl(String url) {
    final basicValidation = validateUrl(url);
    if (basicValidation.isLeft()) return basicValidation;
    
    final cleanUrl = url.trim().toLowerCase();
    
    // Check if it's a TikTok URL (support multiple domains)
    if (!cleanUrl.contains('tiktok.com') && 
        !cleanUrl.contains('vm.tiktok.com') && 
        !cleanUrl.contains('vt.tiktok.com')) {
      return const Left(ValidationFailure(ValidationMessages.invalidTiktokUrl));
    }
    
    print('✅ TikTok URL validation passed: $url');
    return Right(url.trim());
  }
}
