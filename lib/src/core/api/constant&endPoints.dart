class Constants {
  static String? token;
  static String language = 'ar';

  static String baseUrl = "http://194.164.76.46:2121";
}

class EndPoints {
  static const String textToVoice = '/api/v1/order/voice/';
  static const String textToText = '/api/v1/order/chat/';
  static const String closeOrder = '/api/v1/order/close/';
}
