class ApiConstants {
  static const String clientId = 'YOUR_CLIENT_ID.apps.googleusercontent.com';
  static const String clientSecret = 'YOUR_CLIENT_SECRET';
  static const String redirectUri = 'com.yourdomain.drivenotes:/oauth2redirect';
  static const List<String> scopes = [
    'https://www.googleapis.com/auth/drive.file',
    'email',
    'profile',
  ];
  static const String authEndpoint = 'https://accounts.google.com/o/oauth2/v2/auth';
  static const String tokenEndpoint = 'https://oauth2.googleapis.com/token';
  static const String driveApiUrl = 'https://www.googleapis.com/drive/v3';
}