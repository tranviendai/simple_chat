//
// ignore_for_file: non_constant_identifier_names
class AppConfig {
  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();
  static final AppConfig _instance = AppConfig._internal();
  static String env = 'local';

  void init(String env) {
    if (env == 'local') {
      BASE_URL = 'http://localhost:4003/apis/v1/';
      DEVICE_KEY = 'example';
      SOCKET_URL = 'http://localhost:4001/';
      TIMEOUT = 5000;
      env = 'local';
    } else if (env == 'development') {
      BASE_URL = 'https://apis.dev.japan-pachinko-navi.com/apis/v1/';
      REDIRECT_URL = 'http://dev.japan-pachinko-navi.com';
      DEVICE_KEY = 'dRiRA273eJ9xsDkUGEJpu3CVd';
      SOCKET_URL = 'https://sockets.dev.japan-pachinko-navi.com/';
      TIMEOUT = 5000;
      env = 'development';
    } else if (env == 'staging') {
      BASE_URL = 'https://apis.staging.japan-pachinko-navi.com/apis/v1/';
      REDIRECT_URL = 'https://staging.japan-pachinko-navi.com';
      DEVICE_KEY = 'Rqii8a0GLedfO0WCBWs4Xj2h55OOr7Fn';
      SOCKET_URL = 'https://sockets.staging.japan-pachinko-navi.com/';
      TIMEOUT = 5000;
      env = 'staging';
    }
    if (env == 'production') {
      BASE_URL = 'https://apis.japan-pachinko-navi.com/apis/v1/';
      REDIRECT_URL = 'https://japan-pachinko-navi.com';
      DEVICE_KEY = 'Rqii8a0GLedfO0WCBWs4Xj2h55OOr7Fn';
      SOCKET_URL = 'https://sockets.japan-pachinko-navi.com/';
      TIMEOUT = 5000;
      env = 'production';
    }
  }

  late final String BASE_URL;
  late final String DEVICE_KEY;
  late final String SOCKET_URL;
  late final int TIMEOUT;
  late final String REDIRECT_URL;
}
