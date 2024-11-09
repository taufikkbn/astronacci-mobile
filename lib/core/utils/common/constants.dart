class Constants {
  static final Constants _instance = Constants._internal();

  factory Constants() => _instance;

  Constants._internal();

  static String get baseUrl => 'http://10.0.2.2:3000/';
  static String get baseImageUrl => 'http://10.0.2.2:3000/';
}
