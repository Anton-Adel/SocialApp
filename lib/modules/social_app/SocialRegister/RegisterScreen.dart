
import 'package:social_app/layout/social-app/home-screen.dart';
import 'package:social_app/layout/social-app/social-app-cubit/social-app-cubit.dart';

import 'package:social_app/modules/social_app/SocialRegister/cubit/RegisterCubit.dart';
import 'package:social_app/modules/social_app/SocialRegister/cubit/RegisterState.dart';
import 'package:social_app/shared/components/component.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cashHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var mailcontroller= TextEditingController();
  var passwordcontroller= TextEditingController();
  var namecontroller= TextEditingController();
  var phonecontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state){
          if(state is SocialRegisterErrorState)
            {
              showTost(state.error!, TostStatus.ERROR);
            }
          if(state is SocialRegisterSuccessState)
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
          return Scaffold(
              appBar: AppBar(

              ),
              body:    Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('REGISTER',
                            style: Theme.of(context).textTheme.headline3!.copyWith(
                                color: Colors.black
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Register to connect with your friends',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DefaultTextFeild(
                              controller: namecontroller,
                              type: TextInputType.text,
                              label: 'UserName',
                              prefix: Icons.person,
                              validate: (value){
                                if(value!.isEmpty) {
                                  return 'Empty User Name';
                                }
                                else
                                  return null;
                              }),
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
                              password: SocialRegisterCubit.get(context).password,
                              prefix: Icons.lock_outline,
                              suffix: IconButton(
                                onPressed: () {
                                  SocialRegisterCubit.get(context).visible();
                                },
                                icon: Icon(
                                    SocialRegisterCubit.get(context).password? Icons.visibility:Icons.visibility_off
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
                          DefaultTextFeild(
                              controller: phonecontroller,
                              type: TextInputType.phone,
                              label: 'Phone',
                              prefix: Icons.phone,
                              validate: (value){
                                if(value!.isEmpty) {
                                  return 'Empty Phone Number';
                                }
                                else
                                  return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          state is! SocialRegisterLoadinglState?defaultButton(
                            function: (){
                              if(formKey.currentState!.validate())
                              {
                                SocialRegisterCubit.get(context).UserRegister(
                                    name: namecontroller.text,
                                    email: mailcontroller.text,
                                    password: passwordcontroller.text,
                                    phone: phonecontroller.text);

                              }
                            },
                            text: 'register',
                            upper: true,):Center(child: CircularProgressIndicator()),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        },

      ),
    );
  }
}
