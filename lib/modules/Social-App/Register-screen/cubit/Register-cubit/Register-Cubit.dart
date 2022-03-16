// ignore: file_names
// ignore_for_file: file_names

import 'package:assignment3/models/user_model.dart';
import 'package:assignment3/modules/Social-App/Register-screen/cubit/Reegister-state/RegisterStates.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialSate());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool password = true;
  void changePasswordVisible() {
    password = !password;
    emit(RegisterPassWordVisibleSate());
  }

  int radio = 0;
  String? gender = '';
  void changeRadioButton(int value) {
    radio = value;
    if (value == 1) {
      gender = 'Male';
    } else {
      gender = 'Female';
    }
    emit(RegisterChangeRadioSate());
  }

  void Register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String gender,
    required String date,
  }) {
    emit(RegisterSignUpLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid);
      CreateUser(email: email, name: name, phone: phone, gender: gender, date: date, uid:value.user!.uid );
      emit(RegisterSignUpSuccessState(value.user!.uid));
    }).catchError((error) {
      print('hiiii');
      print(error.toString());
      emit(RegisterSignUpErrorState(error.toString()));
    });
  }



  void CreateUser(
      {required String email,
        required String name,
        required String phone,
        required String gender,
        required String date,
        required String uid
      }
      )
  {
    var model = UserModel(
        name:name,
        bio: "Write your bio.......",
        profile:
        "https://img.freepik.com/free-psd/canvas-poster_176382-2255.jpg?w=740",
        cover:
        "https://img.freepik.com/free-psd/canvas-poster_176382-2255.jpg?w=740",
        phone: phone,
        email: email,
        date: date,
        gender: gender,
        uid: uid);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(model.ToMap())
        .then((value) {
          print("Create User is done");
    })
        .catchError((error) {
          print(error.toString());
          emit(RegisterCreateUserErrorState());
    });
  }
}


