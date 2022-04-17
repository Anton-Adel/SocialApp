// ignore: file_names
// ignore_for_file: file_names

abstract class LayoutState{}
class LayoutInitialSate extends LayoutState{}
//get User
class LayoutGetUserLoadinglSate extends LayoutState{}
class LayoutGetUserSuccesslSate extends LayoutState{}
class LayoutGetUserErrorlSate extends LayoutState{}

// get image
class SocialImagePickedSuccessState extends LayoutState{}
class SocialImagePickedErrorState extends LayoutState{}

// send massege

class SocialSendSuccessState extends LayoutState{}
class SocialSendErrorState extends LayoutState{}

//get massege
class SocialGetChatSuccessState extends LayoutState{}

// upload image

class SocialUpdateImageLoading extends LayoutState{}
class SocialUpdateImageSuccessState extends LayoutState{}
class SocialUpdateImageErrorState extends LayoutState{}

// get all users
class SocialGetAllUsersLoadinglState extends LayoutState{}
class SocialGetAllUsersSuccessState extends LayoutState{}
class SocialGetAllUsersErrorState extends LayoutState{}
// remove image
class SocialRemoveImageState extends LayoutState{}
