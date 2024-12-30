import 'package:flutter/material.dart';
import 'package:naver_login_sdk/naver_login_sdk.dart';
import 'package:provider/provider.dart';

import 'package:talk_talk/model/login_data.dart';
import 'package:talk_talk/screens/main_screen.dart';
import 'package:talk_talk/screens/post_create_screen.dart';
import 'package:talk_talk/screens/post_detail_screen.dart';

import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() async {
  KakaoSdk.init(nativeAppKey: 'e796b4586e279a39163bd31dd8265a89');
  WidgetsFlutterBinding.ensureInitialized();
  NaverLoginSDK.initialize(
      clientId: 'csAtf6fxZgPDzVATlrMZ',
      clientSecret: 'm1iveTuaGe',
      clientName: 'talk_talk'
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginData(),
      child: MaterialApp(
        title: '톡톡',
        theme: ThemeData(
          primaryColor: Colors.pinkAccent,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.pinkAccent,
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MainScreen(),
          '/write': (context) => const PostCreateScreen(),
          '/post/detail': (context) => const PostDetailScreen(),
        },
      ),
    );
  }
}