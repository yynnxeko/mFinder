// API Configuration
const String baseUrl = 'http://localhost:5066'; // HTTP endpoint của backend

// API Endpoints
class ApiEndpoints {
  static const String facebookUid = '/api/Uid/fb/extract';
  static const String tiktokUid = '/api/Uid/tiktok/extract';
}

// Validation Messages
class ValidationMessages {
  static const String emptyUrl = 'URL cannot be empty';
  static const String invalidUrl = 'Please enter a valid URL starting with http:// or https://';
  static const String invalidFacebookUrl = 'Please enter a valid Facebook URL';
  static const String invalidTiktokUrl = 'Please enter a valid TikTok URL';
}

// Error Messages
class ErrorMessages {
  static const String noInternet = 'No internet connection. Please check your connection and try again.';
  static const String unexpectedError = 'An unexpected error occurred. Please try again.';
  static const String serverError = 'Server error. Please try again later.';
}

// App Configuration
class AppConfig {
  static const bool useMockData = false;
  static const int networkTimeoutSeconds = 30;
}