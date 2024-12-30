import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:naver_login_sdk/naver_login_sdk.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:talk_talk/enums/login_platform.dart';
import 'package:talk_talk/model/login_data.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    if (googleSignInAccount != null) {
      print('name = ${googleSignInAccount.displayName}');
      print('email = ${googleSignInAccount.email}');
      print('id = ${googleSignInAccount.id}');

      Provider.of<LoginData>(context, listen: false).updateLoginData(LoginPlatform.google);
      Navigator.pop(context);
    }
  }

  Future<void> signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      final profileInfo = json.decode(response.body);
      print(profileInfo.toString());

      Provider.of<LoginData>(context, listen: false).updateLoginData(LoginPlatform.kakao);
      Navigator.pop(context);
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  Future<void> signInWithNaver() async {
     await NaverLoginSDK.authenticate(callback: OAuthLoginCallback(
        onSuccess: () {
          print("onSuccess..");
        },
        onFailure: (httpStatus, message) {
          print("onFailure.. httpStatus:$httpStatus, message:$message");
        },
        onError: (errorCode, message) {
          print("onError.. errorCode:$errorCode, message:$message");
        }
    ));

    Provider.of<LoginData>(context, listen: false).updateLoginData(LoginPlatform.naver);
    Navigator.pop(context);
  }

  Future<void> signOut(LoginPlatform loginPlatform) async {
    switch (loginPlatform) {
      case LoginPlatform.google:
        await GoogleSignIn().signOut();
        break;
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        break;
      case LoginPlatform.naver:
        await NaverLoginSDK.logout();
        break;
      case LoginPlatform.none:
        break;
    }

    Provider.of<LoginData>(context, listen: false).updateLoginData(LoginPlatform.none);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, LoginData loginData, Widget? child) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: AppBar().preferredSize.height,
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                  ),
                  child: null,
                ),
              ),
              if (loginData.loginPlatform != LoginPlatform.none)
                Container(
                  margin: const EdgeInsets.all(9.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: ListTile(
                      trailing: const Icon(Icons.output),
                      title: const Text('로그아웃'),
                      onTap: () {
                        signOut(loginData.loginPlatform);
                      },
                    ),
                  ),
                ),
              if (loginData.loginPlatform == LoginPlatform.none)
                Container(
                  margin: const EdgeInsets.all(9.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: ListTile(
                      trailing: Image.asset(
                        'assets/logos/google_logo.png',
                        width: 30,
                        height: 30,
                      ),
                      title: const Text('구글 로그인'),
                      onTap: () {
                        signInWithGoogle();
                      },
                    ),
                  ),
                ),
              if (loginData.loginPlatform == LoginPlatform.none)
                Container(
                  margin: const EdgeInsets.all(9.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: ListTile(
                      trailing: Image.asset(
                        'assets/logos/naver_logo.png',
                        width: 30,
                        height: 30,
                      ),
                      title: const Text('네이버 로그인'),
                      onTap: () {
                        signInWithNaver();
                      },
                    ),
                  ),
                ),
              if (loginData.loginPlatform == LoginPlatform.none)
                Container(
                  margin: const EdgeInsets.all(9.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: ListTile(
                      trailing: Image.asset(
                        'assets/logos/kakao_logo.png',
                        width: 30,
                        height: 30,
                      ),
                      title: const Text('카카오 로그인'),
                      onTap: () {
                        signInWithKakao();
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
