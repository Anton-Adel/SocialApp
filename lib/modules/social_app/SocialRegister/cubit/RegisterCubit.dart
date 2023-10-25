import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/social-app/social-user-model.dart';

import 'package:social_app/modules/social_app/SocialRegister/cubit/RegisterState.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void UserRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}
      ) {
    
    emit(SocialRegisterLoadinglState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      CreateUser(name: name, email: email, phone: phone, uId: value.user!.uid);
      emit(SocialRegisterSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void CreateUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  })
  {
    SocialUserModel model = SocialUserModel(
        name: name, email: email, phone: phone, uId: uId, IsVerified: false,
      cover: 'https://img.freepik.com/free-psd/canvas-poster_176382-2255.jpg?w=740',
      profile: 'https://img.freepik.com/free-psd/canvas-poster_176382-2255.jpg?w=740',
      bio: 'Write your bio...... '
    );
    FirebaseFirestore.instance
        .collection("user")
        .doc(uId)
        .set(model.ToMap())
        .then((value) {
      print("TOnY");
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  bool password = true;
  void visible() {
    password = !password;
    emit(SocialRegisterpasswordVisiability());
  }
}
