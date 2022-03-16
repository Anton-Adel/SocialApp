// ignore: file_names
// ignore_for_file: file_names

import 'package:assignment3/modules/Social-App/Profile-Screen/profile-screen.dart';
import 'package:assignment3/modules/Social-App/login-screen/Login-Screen.dart';
import 'package:assignment3/shared/cross-the-app/component.dart';
import 'package:assignment3/shared/cross-the-app/constants.dart';
import 'package:assignment3/shared/network/Local/CashHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'cubit/Reegister-state/RegisterStates.dart';
import 'cubit/Register-cubit/Register-Cubit.dart';


class SignUp extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  late DateTime _dateOfBirth;
  Widget build(BuildContext context) {
    double scwidth = MediaQuery.of(context).size.width;
    double scheight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if(state is RegisterSignUpSuccessState)
              {
                CashHelper.SetData(key: 'uId', value: state.uId).then((value){
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(
                      content: Text(
                          "Welcome")));
                  uid=state.uId!;
                  navigate(context, ProfileScreen());

                }).catchError((error){

                });

              }
            else if(state is RegisterSignUpErrorState)
              {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(
                    content: Text(
                        "${state.error}")));
              }


          },
          builder: (context, state) {
            return Scaffold(
                body: SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.only(top: 40),
                        color: Colors.white,
                        width: scwidth,
                        height: scheight,
                        child: Column(children: [
                          Container(
                            //padding: EdgeInsets.only(top: 10),
                            width: scwidth,
                            //height: scheight*0.8,
                            child: Column(
                              children: [
                                Form(
                                    key: _formkey,
                                    child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 60),
                                                  width: scwidth * 0.4,
                                                  color: Colors.white,
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: TextFormField(
                                                      controller:
                                                          _firstnameController,
                                                      decoration:
                                                          InputDecoration(
                                                        // border: InputBorder.none,
                                                        hintText: "First name",
                                                        // prefixIcon: Icon(Icons.email)
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter the first name';
                                                        }
                                                      }),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 60),
                                                  width: scwidth * 0.4,
                                                  color: Colors.white,
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: TextFormField(
                                                      controller:
                                                          _surnameController,
                                                      decoration:
                                                          InputDecoration(
                                                        //border: InputBorder.none,
                                                        hintText: "Surname",
                                                        // prefixIcon: Icon(Icons.email)
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter the surname';
                                                        }
                                                      }),
                                                ),
                                              ]),
                                          Container(
                                            width: scwidth * 0.9,
                                            margin: EdgeInsets.only(top: 20),
                                            color: Colors.white,
                                            padding: EdgeInsets.only(left: 10),
                                            child: TextFormField(
                                                controller: _emailController,
                                                decoration: InputDecoration(
                                                  //border: InputBorder.none,
                                                  hintText: "Email address",
                                                  //prefixIcon: Icon(Icons.vpn_key)
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter the email address';
                                                  }
                                                }),
                                          ),
                                          Container(
                                            width: scwidth * 0.9,
                                            margin: EdgeInsets.only(top: 20),
                                            color: Colors.white,
                                            padding: EdgeInsets.only(left: 10),
                                            child: TextFormField(
                                                controller: _passwordController,
                                                decoration: InputDecoration(
                                                    // border: InputBorder.none,
                                                    hintText: "Password",
                                                    suffixIcon: IconButton(
                                                      icon: Icon(RegisterCubit
                                                                  .get(context)
                                                              .password
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off),
                                                      onPressed: () {
                                                        RegisterCubit.get(
                                                                context)
                                                            .changePasswordVisible();
                                                        // setState(() {
                                                        //   passwordVisible = !passwordVisible;
                                                        // });
                                                      },
                                                    )),
                                                obscureText:
                                                    RegisterCubit.get(context)
                                                        .password,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter the password';
                                                  }
                                                }),
                                          ),
                                          Container(
                                            width: scwidth * 0.9,
                                            color: Colors.white,
                                            padding: EdgeInsets.only(left: 10),
                                            margin: EdgeInsets.only(top: 20),
                                            child: TextField(
                                              controller:
                                                  _phonenumberController,
                                              decoration: InputDecoration(
                                                // border: InputBorder.none,
                                                hintText:
                                                    "Phone number (optional)",
                                              ),
                                            ),
                                          ),
                                        ])),
                                //SizedBox(height:20),
//          Container(
//              width: scwidth * 0.9,
//              color: Colors.white,
//              padding: EdgeInsets.only(left: 10),
//              child: TextField(
//
//                  controller: _phonenumberController,
//                  decoration: InputDecoration(
//                    // border: InputBorder.none,
//                      hintText: "Phone number (optional)",
//
//                  ),
//          ),
//          ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 30, top: 20, right: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Date of Birth     ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextField(
                                        readOnly: true,
                                        controller: _dateOfBirthController,
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1950),
                                                  lastDate: DateTime.now())
                                              .then((value) {
                                            _dateOfBirthController.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                          });
                                        },
                                        decoration: InputDecoration(
                                            hintText: "YYYY-MM-DD",
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.6,
                                                    color: Colors.black87),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.calendar_today),
                                              onPressed: () {},
                                            )),
                                      ))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30, top: 30),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Gender",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: RadioListTile(
                                          value: 1,
                                          groupValue:
                                              RegisterCubit.get(context).radio,
                                          onChanged: (value) {
                                            RegisterCubit.get(context)
                                                .changeRadioButton(
                                                    value as int);
                                          },
                                          title: Text("M"),
                                        ),
                                      ),
                                      Expanded(
                                          child: RadioListTile(
                                        value: 2,
                                        groupValue:
                                            RegisterCubit.get(context).radio,
                                        onChanged: (value) {
                                          RegisterCubit.get(context)
                                              .changeRadioButton(value as int);
                                        },
                                        title: Text("F"),
                                      ))
                                    ],
                                  ),
                                ),
                                ButtonTheme(
                                  minWidth: scwidth * 0.9,
                                  child: RaisedButton(
                                    color: Colors.deepOrange,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Account is created successfully")));
                                        RegisterCubit.get(context).Register(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            name: (_firstnameController.text +" "+
                                                _surnameController.text),
                                            phone: _phonenumberController.text,
                                            gender: RegisterCubit.get(context).gender!,
                                            date: _dateOfBirthController.text);
                                      }
                                    },
                                    child: Text("Sign Up"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: scwidth * 0.05, top: 15),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Already have an account? "),
                                        GestureDetector(
                                            onTap: () {
                                              navigate(context, LoginScreen());
                                            },
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                color: Colors.deepOrange,
                                              ),
                                            ))
                                      ]),
                                ),
                              ],
                            ),
                          )
                        ]))));
          }),
    );
  }
}
