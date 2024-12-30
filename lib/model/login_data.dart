import 'package:flutter/foundation.dart';
import 'package:talk_talk/enums/login_platform.dart';

class LoginData extends ChangeNotifier {
  LoginPlatform loginPlatform = LoginPlatform.none;

  LoginPlatform get loginState => loginPlatform;

  void updateLoginData(LoginPlatform newLoginPlatform) {
    loginPlatform = newLoginPlatform;

    notifyListeners();
  }
}