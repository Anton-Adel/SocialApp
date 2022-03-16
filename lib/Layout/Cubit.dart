import 'package:assignment3/Layout/States.dart';
import 'package:assignment3/models/user_model.dart';
import 'package:assignment3/shared/cross-the-app/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class layoutCubit extends Cubit<LayoutState>{
  layoutCubit() : super(LayoutInitialSate());
  static layoutCubit get(context)=>BlocProvider.of(context);
  UserModel? model;
  void getUser(){
    emit(LayoutGetUserLoadinglSate());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      model=UserModel.fromjson(value.data()!);
      print(model!.email);
      print("Anton");
      emit(LayoutGetUserSuccesslSate());
    })
    .catchError((error){
      print(error.toString());
      emit(LayoutGetUserErrorlSate());
    });
  }
}