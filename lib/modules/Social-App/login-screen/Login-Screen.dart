// ignore: file_names

// ignore_for_file: file_names

import 'package:assignment3/Layout/Cubit.dart';
import 'package:assignment3/modules/Social-App/Profile-Screen/profile-screen.dart';
import 'package:assignment3/modules/Social-App/Register-screen/register-screen.dart';
import 'package:assignment3/shared/cross-the-app/component.dart';
import 'package:assignment3/shared/cross-the-app/constants.dart';
import 'package:assignment3/shared/network/Local/CashHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'cubit/login-screen-cubit.dart';
import 'cubit/login-screen-states.dart';

class LoginScreen extends StatelessWidget {
  bool password = true;
  var EmailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),

      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState)
          {

            CashHelper.SetData(key: 'uId', value: state.uId).then((value){
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(
                  content: Text(
                      "Welcome")));
              uid=state.uId!;
              layoutCubit.get(context).getUser();
              navigate(context, ProfileScreen());

            }).catchError((error){

            });
          }
          else if(state is LoginErrorState)
          {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
                content: Text(
                    "${state.error}")));
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              leading: const Icon(Icons.lock),
              title: const Text(

                'Login Screen',
                style: TextStyle(fontSize: 25),
              ),
              backgroundColor: Colors.orange,
            ),

            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Share your photos and posts with your friends ',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),

                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: const Image(image: AssetImage("assets/images/Facebook.png"),
                              height: 90,
                              width: 90,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style:
                            TextStyle(fontSize: 40, fontWeight: FontWeight.bold,),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          DefaultTextFeild(
                            label: 'e-mail',
                            controller: EmailController,
                            validate: (ss) {
                              if (ss!.isEmpty)
                                return "Empty e-mail";
                              else
                                return null;
                            },
                            prefix: Icons.email,
                            type: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          DefaultTextFeild(
                            label: 'Password',
                            controller: passwordController,
                            validate: (ss) {
                              if (ss!.isEmpty)
                                return "Empty Password";
                              else
                                return null;
                            },
                            prefix: Icons.lock,
                            password: LoginCubit.get(context).password,
                            suffix: IconButton(
                              onPressed: () {
                               LoginCubit.get(context).changePasswordVisible();
                              },
                              icon: Icon(
                                  LoginCubit.get(context).password ? Icons.visibility : Icons.visibility_off),
                            ),
                            type: TextInputType.visiblePassword,
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).UserLogin(email: EmailController.text, password: passwordController.text);
                              }
                            },
                            text: "login",
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(fontSize: 15),
                              ),
                              TextButton(
                                onPressed: () {

                                  navigate(context, SignUp());
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.orange
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}

