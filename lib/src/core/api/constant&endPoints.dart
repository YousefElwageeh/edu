class Constants {
  static String? studentId;
  static String language = 'ar';
  static String apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1aXdkanRtZGVlbXBjcXhldWhmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ3NTY1MDcsImV4cCI6MjA2MDMzMjUwN30.XfSmnKA8wbsXIA1qkfYaRkzxtEdudIDNYbSJu-M5Zag';

  static String baseUrl = "https://iuiwdjtmdeempcqxeuhf.supabase.co/rest/v1";
}

class EndPoints {
  static const String baseUrl =
      "https://iuiwdjtmdeempcqxeuhf.supabase.co/rest/v1";
  static const String student = '/student';
  static const String enrollment = '/enrollment';
  static const String quiz = '/quiz';
  static const String calendar = '/calendar_event';

  static const String closeOrder = '/api/v1/order/close/';
}
