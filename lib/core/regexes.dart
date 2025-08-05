class Regexes {
  static final RegExp nameAndFamily =
      RegExp(r'^[A-Za-z\u0600-\u06FF]+(?: [A-Za-z\u0600-\u06FF]+)*$');
  static final RegExp emojiRegex = RegExp(r'\p{Emoji}', unicode: true);
  static final englishRegex = RegExp(r'^[A-Za-z\s]+$');
  static final persianRegex = RegExp(r'^[\u0600-\u06FF\s]+$');
  static final persianDetector = RegExp(r'[\u0600-\u06FF]');
  static final englishDetector = RegExp(r'[A-Za-z]');
  static final persianNumber = RegExp(r'[۰-۹]+([٫٫][۰-۹]+)?');
  static final invalidEmail = RegExp(r'[^a-zA-Z0-9@.]+');
  static final invalidPassword = RegExp(r'[^A-Za-z0-9!@#\$&*~]+');
static final password = 
  RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$');


  static bool isValidPassword(String input) => password.hasMatch(input);

  static bool isValidName(String input) =>
      englishRegex.hasMatch(input) || persianRegex.hasMatch(input);
}
