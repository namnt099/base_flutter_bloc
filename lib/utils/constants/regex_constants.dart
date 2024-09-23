class RegexConstants {
  RegexConstants._();
  static const EMAIL_REGEX =
      r'^([a-zA-Z][a-zA-Z0-9_\.]{3,})+@[a-zA-Z0-9]{2,}(\.[a-zA-Z0-9]{2,})+$';
  static const PASSWORD_REGEX = r'^(?=.*?[A-Z]).{8,20}$';
  static const USERNAME_REGEX = r'^[a-zA-Z0-9_]*$';
  static const VN_PHONE = r'(84|0[3|5|7|8|9])+([0-9]{8})\b';
  static const DECIMAL_REGEX = r'([.]*0+)(?!.*\d)';
  static const DOUBLE_REGEX = r'(^\d*\.?\d{0,6})';
  static const CHARACTER_REGEX = r'^[a-zA-Z0-9_.-]*$';
  static const PASSWORD_REGEX_2 =
      r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#&()–\[{}\]:;',?/%*~$^+=<>]).{8,100}$";
  static const SPACE_CHARACTER = ' ';

  bool isEmail(String email) {
    return RegExp(EMAIL_REGEX).hasMatch(email);
  }

  bool isUserName(String userName) {
    return RegExp(USERNAME_REGEX).hasMatch(userName);
  }

  bool isPassword(String password) {
    return RegExp(PASSWORD_REGEX).hasMatch(password);
  }

  bool isVNPhone(String phone) {
    return RegExp(VN_PHONE).hasMatch(phone);
  }
}
