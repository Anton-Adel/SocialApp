
import 'package:social_app/layout/social-app/home-screen.dart';
import 'package:social_app/layout/social-app/social-app-cubit/social-app-cubit.dart';
import 'package:social_app/modules/social_app/SocialRegister/RegisterScreen.dart';
import 'package:social_app/modules/social_app/social-login/cubit/social-login_cubit.dart';
import 'package:social_app/modules/social_app/social-login/cubit/social-login_states.dart';
import 'package:social_app/shared/components/component.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cashHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var mailcontroller= TextEditingController();
  var passwordcontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialAppCubit(),
      child: BlocConsumer<SocialAppCubit,SocialAppStates>(
        listener: (context,state){
          if(state is SocialAppErrorState)
            showTost(state.error!, TostStatus.ERROR);

          else if(state is SocialAppSuccessState)
            {
              CashHelper.SetData(key: 'uId', value: state.uId).then((value) {
                uId= state.uId;
                SocialLayoutCubit.get(context).GetUserData();
                navigate(context, SocialHomeScreen());
                showTost("Welcome", TostStatus.SUCCESS);
              }).catchError((error){
                print(error.toString());
              });
            }

        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Login to connect with your friends',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DefaultTextFeild(
                            controller: mailcontroller,
                            type: TextInputType.emailAddress,
                            label: 'e-mail',
                            prefix: Icons.email_outlined,
                            validate: (value){
                              if(value!.isEmpty) {
                                return 'Empty e-mail';
                              }
                              else
                                return null;
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        DefaultTextFeild(
                            controller: passwordcontroller,
                            type: TextInputType.visiblePassword,
                            label: 'password',
                            password: SocialAppCubit.get(context).password,
                            prefix: Icons.lock_outline,
                            suffix: IconButton(
                              onPressed: () {
                                SocialAppCubit.get(context).visible();
                              },
                              icon: Icon(
                                  SocialAppCubit.get(context).password? Icons.visibility:Icons.visibility_off
                              ),
                            ),
                            validate: (value){
                              if(value!.isEmpty) {
                                return 'Empty password';
                              }
                              else
                                return null;
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        state is! SocialAppLoadinglState?defaultButton(
                          function: (){
                            if(formKey.currentState!.validate())
                            {
                              SocialAppCubit.get(context).UserLogin(email: mailcontroller.text, password: passwordcontroller.text);

                            }
                          },
                          text: 'Login',
                          upper: true,):Center(child: CircularProgressIndicator()),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\’t have an acount',
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                            TextButton(onPressed: (){
                              navigate(context, RegisterScreen());
                            },
                              child: Text('REGESTER'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );;
  }
}
