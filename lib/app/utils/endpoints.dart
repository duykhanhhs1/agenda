abstract class Endpoints {
  static const String API_URL = 'https://dev.goalmaker.com.au:1100/api';
  static const String DOWNLOAD_PHOTO_URL = 'https://dev.goalmaker.com.au:1100';
  static const String VERIFY_EMAIL = '${API_URL}/users/same-users';
  static const String LOGIN = '${API_URL}/users/login';
  static const String USER_PROFILE = '$API_URL/users/profile';
  static const String REFRESH_TOKEN = '${API_URL}/users/refresh-token';
  static const String QUESTIONNAIRES = '$API_URL/questionnaires';
  static const String UPLOAD_PHOTO = '${API_URL}/questionnaires/upload-photo';
}
