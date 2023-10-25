import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/Endpoint.dart';
import 'package:social_app/shared/network/local/cashHelper.dart';

import 'layout/social-app/home-screen.dart';
import 'layout/social-app/social-app-cubit/social-app-cubit.dart';
import 'modules/social_app/social-login/social-login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();
  Widget widget_;
  print("TONT");
  print(uId);
  if (uId != null) {
    widget_ = SocialHomeScreen();
  }
  else {
    widget_ = SocialLoginScreen();
  }
  runApp(MyApp(widget: widget_,));
}

class MyApp extends StatelessWidget {
  Widget? widget;

  MyApp({
    this.widget
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLayoutCubit()..GetUserData()..GetPosts(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: widget,
      ),
    );
  }
}