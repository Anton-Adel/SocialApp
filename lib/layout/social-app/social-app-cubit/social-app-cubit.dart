import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/layout/social-app/social-app-cubit/social-app-states.dart';
import 'package:social_app/models/social-app/MassegeModel.dart';
import 'package:social_app/models/social-app/social-post-model.dart';
import 'package:social_app/models/social-app/social-user-model.dart';
import 'package:social_app/modules/social_app/Chat/Social-chat_screen.dart';
import 'package:social_app/modules/social_app/Feeds/Social-Feeds_screen.dart';
import 'package:social_app/modules/social_app/Setting/Social-Setting_screen.dart';
import 'package:social_app/modules/social_app/Social-add-post-screen/Social-Add-Post.dart';
import 'package:social_app/modules/social_app/Users/Social-Users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialLayoutCubit extends Cubit<SocialStates> {
  SocialLayoutCubit() : super(SocialInitialState());
  static SocialLayoutCubit get(context) => BlocProvider.of(context);
  SocialUserModel? model;

  void GetUserData() {
    emit(SocialGetUserModelLoadinglState());

    FirebaseFirestore.instance.collection('user').doc(uId).get().then((value) {
      print(value.data());
      model = SocialUserModel.fromjson(value.data()!);
      emit(SocialGetUserModelSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserModelErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> Screens = [
    SocialFeedsScreen(),
    SocialChatScreen(),
    Social_Add_Post(),
    SocialUsersScreen(),
    SocialSettingsScreen(),
  ];

  List<String> titles = ['Home', 'Chat', 'Posts', 'Users', 'Setting'];

  void ChangeScreen(int index) {
    if (index == 1) GetUsers();
    if (index == 2) {
      emit(SocialPostState());
      index = 0;
    } else {
      currentIndex = index;
      emit(SocialBottomNavBarState());
    }
  }

  File? profileImage;
  var Picker = ImagePicker();
  Future<void> GetProfileImage() async {
    final PickerFile = await Picker.pickImage(source: ImageSource.gallery);
    if (PickerFile != null) {
      profileImage = File(PickerFile.path);
      print(profileImage);
      emit(SocialProfilePickedSuccessState());
    } else {
      emit(SocialProfilePickedErrorState());
    }
  }

  File? coverImage;
  var coverPicker = ImagePicker();
  Future<void> GetCoverImage() async {
    final PickerFile = await coverPicker.pickImage(source: ImageSource.gallery);
    if (PickerFile != null) {
      coverImage = File(PickerFile.path);
      emit(SocialCoverPickedSuccessState());
    } else {
      emit(SocialCoverPickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateProfileLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        UpdateUserDate(name: name, phone: phone, bio: bio, profile: value);
        profileImage = null;
        emit(SocialUpdateProfileSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUpdateProfileErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateProfileErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateCoverLoading());
    print(coverImage!.path);
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImage = null;
        UpdateUserDate(name: name, phone: phone, bio: bio, cover: value);

        emit(SocialUpdateProfileSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUpdateProfileErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateProfileErrorState());
    });
  }

  void UpdateUserDate({
    required String name,
    required String phone,
    required String bio,
    String? profile,
    String? cover,
  }) {
    emit(SocialUpdateUserLoading());
    SocialUserModel model_ = SocialUserModel(
        name: name,
        email: model!.email,
        phone: phone,
        uId: uId,
        IsVerified: false,
        cover: cover ?? model!.cover,
        profile: profile ?? model!.profile,
        bio: bio);
    FirebaseFirestore.instance
        .collection('user')
        .doc(model!.uId)
        .update(model_.ToMap())
        .then((value) {
      print('done123');
      GetUserData();
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateUserErrorState());
    });
  }

  File? PostImage;
  Future<void> GetPostImage() async {
    final PickerFile = await coverPicker.pickImage(source: ImageSource.gallery);
    if (PickerFile != null) {
      PostImage = File(PickerFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String text,
    required String dataTime,
  }) {
    emit(SocialUploadPostImageLoading());
    //print(coverImage!.path);
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CreatePost(text: text, dataTime: dataTime, postImage: value);

        emit(SocialUploadPostImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadPostImageErrorState());
    });
  }

  void CreatePost(
      {required String text, required String dataTime, String? postImage}) {
    emit(SocialCreatePostLoading());

    SocialPostModel model_ = SocialPostModel(
        text: text,
        profile: model!.profile,
        name: model!.name,
        dateTime: dataTime,
        postImage: postImage ?? '',
        uId: model!.uId);
    FirebaseFirestore.instance
        .collection('posts')
        .add(model_.ToMap())
        .then((value) {
      print('done123');
      GetPosts();
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void RemovePostImage() {
    PostImage = null;
    emit(SocialRemovePostImageState());
  }

  List<SocialPostModel> post = [];
  List<String> PostId = [];
  List<int> PostLikes = [];

  void GetPosts() {
    emit(SocialGetPostModelLoadinglState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      post = [];
      PostId = [];
      PostLikes = [];
      event.docs.forEach((element) {
        element.reference.collection('likes')
            .snapshots()
        .listen((event) {
          PostLikes.add(event.docs.length);

          PostId.add(element.id);
          post.add(SocialPostModel.fromjson(element.data()));
          emit(SocialGetPostModelSuccessState());
        });
      });
    });
  }



  // void GetPosts() {
  //   post = [];
  //   PostId = [];
  //   PostLikes = [];
  //   emit(SocialGetPostModelLoadinglState());
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .orderBy('dateTime')
  //       .get()
  //       .then((value)
  //   {
  //     value.docs.forEach((element) {
  //       element.reference.collection('likes').get().then((value) {
  //         PostLikes.add(value.docs.length);
  //
  //         PostId.add(element.id);
  //         post.add(SocialPostModel.fromjson(element.data()));
  //         emit(SocialGetPostModelSuccessState());
  //       }).catchError((error) {
  //         emit(SocialGetPostModelErrorState(error.toString()));
  //       });
  //     });
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(SocialGetPostModelErrorState(error.toString()));
  //   });
  // }

  void like_or(index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(index)
        .collection('likes')
        .doc(model!.uId)
        .get()
        .then((value) {
      Map<String, dynamic>? like = value.data();
      print(like!['like']);
      if (like['like'] != null) dislike(index);
    }).catchError((error) {
      LikePost(index);

      emit(SocialLikeOrErrorState(error.toString()));
    });
  }

  void LikePost(index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(index)
        .collection('likes')
        .doc(model!.uId)
        .set({
      'like': true,
    }).then((value) {
      GetPosts();
      emit(SocialLikeSuccessState());
    }).catchError((error) {
      emit(SocialLikeErrorState(error.toString()));
    });
  }

  void dislike(index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(index)
        .collection('likes')
        .doc(model!.uId)
        .delete()
        .then((value) {
      GetPosts();
      emit(SocialDisLikeSuccessState());
    }).catchError((error) {
      emit(SocialDisLikeErrorState(error.toString()));
    });
  }

  List<SocialUserModel> Users = [];

  void GetUsers() {
    Users = [];
    emit(SocialGetAllUsersLoadinglState());
    FirebaseFirestore.instance.collection('user').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != model!.uId)
          Users.add(SocialUserModel.fromjson(element.data()));
        emit(SocialGetAllUsersSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }

  void SendMassege(
      {required String text,
        required String receveruid,
        required String date})
  {
    MassegeModel model_ = MassegeModel(
        Date: date, ReseveruId: receveruid, SenderuId: model!.uId, Text: text);
    FirebaseFirestore.instance
        .collection('user')
        .doc(model!.uId)
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
        .collection('user')
        .doc(receveruid)
        .collection('chats')
        .doc(model!.uId)
        .collection('massages')
        .add(model_.ToMap())
        .then((value)  {
      emit(SocialSendSuccessState());
    })
        .catchError((error) {
      emit(SocialSendErrorState());
    });
  }
  List<MassegeModel> masseges=[];
  void GetMasseges({
  required String receveruid
}){

    FirebaseFirestore.instance.collection('user')
        .doc(model!.uId)
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
