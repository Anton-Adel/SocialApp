import 'package:firebase_auth/firebase_auth.dart';

import 'package:social_app/models/social-app/social-user-model.dart';
import 'package:social_app/modules/social_app/social-login/cubit/social-login_states.dart';
import 'package:social_app/shared/network/Endpoint.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SocialAppCubit extends Cubit<SocialAppStates>
{

  SocialAppCubit():super(SocialAppInitialState());
  static SocialAppCubit get(context)=> BlocProvider.of(context);
SocialUserModel? model;

  void UserLogin(
  {
  required String email,
    required String password
}
){
  FirebaseAuth.instance.signInWithEmailAndPassword
    (email: email, password: password,).then((value) {
      print(value.user!.email);
      emit(SocialAppSuccessState(value.user!.uid));
  }).catchError((error){
    emit(SocialAppErrorState(error.toString()));
  });
  }

  bool password=true;
  void visible(){
    password=!password;
    emit(SocialApppasswordVisiability());
  }
}