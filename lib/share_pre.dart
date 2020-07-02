import 'package:shared_preferences/shared_preferences.dart';

class SharedPre {
  static SharedPreferences pre;

  static Future<void> init() async {
    pre = await SharedPreferences.getInstance();
    return null;
  }

  static Future<bool> clearAll() async {
    return pre.clear();
  }

  static void saveToken(String token) {
    pre.setString('token', token);
    saveTokenTime(DateTime.now().millisecondsSinceEpoch);
  }

  static String getToken() {
    return pre.getString('token') ?? '';
  }

  static void saveTokenTime(int timeMilli) {
    pre.setInt("saveTokenTime", timeMilli);
  }

  static int getTokenTime() {
    return pre.getInt("saveTokenTime") ?? 0;
  }

  static void saveUsername(String username) {
    pre.setString('username', username);
  }

  static String getUsername() {
    return pre.getString('username') ?? '';
  }

  static void savePassword(String password) {
    pre.setString('password', password);
  }

  static String getPassword() {
    return pre.getString('password') ?? '';
  }

  static void rememberPassword(bool isChecked) {
    pre.setBool('remember_password', isChecked);
  }

  static bool isRememberPassword() {
    return pre.getBool('remember_password') ?? true;
  }
}
