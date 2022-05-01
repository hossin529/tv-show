class AppConfig {
  static Environment env = Environment.prod;
  static String baseUrl = env == Environment.dev ? '' : 'api.themoviedb.org';
  static const String path = '/3';
  static const String apiKey = '3b17e19f0c4b78377d038324168e2cca';
  static const String imagePath = 'https://image.tmdb.org/t/p/w500';
  static const String emptyImagePath =
      'https://webcolours.ca/wp-content/uploads/2020/10/webcolours-unknown.png';
  static const String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYjE3ZTE5ZjBjNGI3ODM3N2QwMzgzMjQxNjhlMmNjYSIsInN1YiI6IjYyNmQ3ZTQ2MjQ1ZGJlMDA2NTQzY2U1MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.q1CKdUlRSeQFkY0SF89sJA1OHNjO6LltX2eebyAom8g';
  static const String appName = 'Tv Show';
  static const String appVersion = "Version 1.0.0";
  static const int appVersionCode = 1;
  static bool debugMode = false;
}

enum Environment { dev, prod }
