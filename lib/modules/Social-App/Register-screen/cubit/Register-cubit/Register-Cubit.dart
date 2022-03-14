// ignore: file_names
// ignore_for_file: file_names


import 'package:assignment3/modules/Social-App/Register-screen/cubit/Reegister-state/RegisterStates.dart';
import 'package:bloc/bloc.dart';
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
  String? gender='';
  void changeRadioButton(int value) {
    radio = value;
    if(value==1)
      {
        gender='Male';
      }
    else
      {
        gender='Female';
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
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
      print(value.user!.uid);
      emit(RegisterSignUpSuccessState(value.user!.uid));
    }).catchError((error){
      print('hiiii');
      print(error.toString());
      emit(RegisterSignUpErrorState(error.toString()));
    });

  }
}
