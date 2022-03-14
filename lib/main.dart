
import 'package:assignment3/modules/Social-App/Profile-Screen/profile-screen.dart';
import 'package:assignment3/modules/Social-App/login-screen/Login-Screen.dart';
import 'package:assignment3/shared/cross-the-app/constants.dart';
import 'package:assignment3/shared/network/Local/CashHelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'modules/Social-App/Register-screen/register-screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();

  Widget?widget;
  uid=CashHelper.getData('uId');
  if(uid!=null)
    {
      widget=ProfileScreen();
    }
  else{

    widget=LoginScreen();
  }
  print(uid);
  runApp(App(widget));
}
class App extends StatelessWidget{
  Widget?widget;
  App(this.widget);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
    debugShowCheckedModeBanner: false
    ,home: widget);
  }
}
