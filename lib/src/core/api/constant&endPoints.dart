class Constants {
  static String? studentId;
  static String? studentName;
  static String? institutionId;
  static String language = 'ar';
  static String apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im53d3FzcWt3bWtrdXVuY3p1Y2RtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY1MzEyODIsImV4cCI6MjA2MjEwNzI4Mn0.EF6CGrpM3bjxBo4-ItU3S1BPjfVHdv2HnvoeAdfPZug';

  static String baseUrl = "https://nwwqsqkwmkkuunczucdm.supabase.co/rest/v1";
}

class EndPoints {
  static const String baseUrl =
      "https://nwwqsqkwmkkuunczucdm.supabase.co/rest/v1";
  static const String student = '/student';
  static const String enrollment = '/enrollment';
  static const String quiz = '/quiz';
  static const String calendar = '/calendar_event';

  static const String closeOrder = '/api/v1/order/close/';
}
