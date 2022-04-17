import 'dart:io';

import 'package:assignment3/Layout/States.dart';
import 'package:assignment3/models/MassegeModel.dart';
import 'package:assignment3/models/user_model.dart';
import 'package:assignment3/shared/cross-the-app/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
      GetUsers();
      emit(LayoutGetUserSuccesslSate());
    })
    .catchError((error){
      print(error.toString());
      emit(LayoutGetUserErrorlSate());
    });
  }


  List<UserModel> Users = [];

  void GetUsers() {
    Users = [];
    emit(SocialGetAllUsersLoadinglState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uid'] != model!.uid)
          Users.add(UserModel.fromjson(element.data()));
        emit(SocialGetAllUsersSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetAllUsersErrorState());
    });
  }


  File? Image;
  var coverPicker = ImagePicker();
  Future<void> GetImage() async {
    final PickerFile = await coverPicker.pickImage(source: ImageSource.gallery);
    if (PickerFile != null) {
      Image = File(PickerFile.path);
      emit(SocialImagePickedSuccessState());
    } else {
      emit(SocialImagePickedErrorState());
    }
  }
  void RemovePostImage() {
    Image = null;
    emit(SocialRemoveImageState());
  }

  void SendMassege(
      {required String text,
        required String receveruid,
        required String date,
      String? image
      })
  {
    MassegeModel model_ = MassegeModel(
        Date: date, ReseveruId: receveruid, SenderuId: model!.uid, Text: text,image: image??'');
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(receveruid)
        .collection('massages')
        .add(model_.ToMap())
        .then((value)  {
      emit(SocialSendSuccessState());
    })
        .catchError((error) {
      emit(SocialSendErrorState());
    });


    FirebaseFirestore.instance
        .collection('users')
        .doc(receveruid)
        .collection('chats')
        .doc(model!.uid)
        .collection('massages')
        .add(model_.ToMap())
        .then((value)  {
      emit(SocialSendSuccessState());
    })
        .catchError((error) {
      emit(SocialSendErrorState());
    });
  }



  void uploadImage({
    required String text,
    required String receveruid,
    required String date}) {
    emit(SocialUpdateImageLoading());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chat/${Uri.file(Image!.path).pathSegments.last}')
        .putFile(Image!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        Image = null;
        SendMassege(text: text, receveruid: receveruid, date: date,image: value);
        emit(SocialUpdateImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUpdateImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateImageErrorState());
    });
  }


  List<MassegeModel> masseges=[];
  void GetMasseges({
    required String receveruid
  }){

    FirebaseFirestore.instance.collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(receveruid)
        .collection('massages')
        .orderBy('Date')
        .snapshots()
        .listen((event){
      masseges=[];
      event.docs.forEach((element) {
        masseges.add(MassegeModel.fromjson(element.data()));

      });
      emit(SocialGetChatSuccessState())  ;

    } );

  }





}