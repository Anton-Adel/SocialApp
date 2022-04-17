
import 'package:assignment3/Layout/Cubit.dart';
import 'package:assignment3/Layout/States.dart';
import 'package:assignment3/modules/Social-App/Chat/Users.dart';
import 'package:assignment3/modules/Social-App/Profile-Screen/profile-screen.dart';
import 'package:assignment3/modules/Social-App/login-screen/Login-Screen.dart';
import 'package:assignment3/shared/cross-the-app/constants.dart';
import 'package:assignment3/shared/network/Local/CashHelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(

      create: (BuildContext context) =>layoutCubit()..getUser(),
      child: BlocConsumer<layoutCubit,LayoutState>(
        listener: (context,state){},
        builder: (context,state)
        {
          return  MaterialApp(
            debugShowCheckedModeBanner: false
            ,home: SocialChatScreen(),
            theme: ThemeData(scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                backwardsCompatibility:false ,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark

                ),

                iconTheme: IconThemeData(
                    color: Colors.black
                ),

                elevation: 0.0,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,

                ),
                //backgroundColor: Colors.grey[300],


                actionsIconTheme: IconThemeData(
                    color: Colors.black
                ),
                titleSpacing: 20,
              ),

            ),
            themeMode: ThemeMode.light,
          );
        }

      ),
    );
  }
}
