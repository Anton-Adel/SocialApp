abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserModelLoadinglState extends SocialStates{}
class SocialGetUserModelSuccessState extends SocialStates{}
class SocialGetUserModelErrorState extends SocialStates{
  String? error;
  SocialGetUserModelErrorState(this.error);

}

//get post
class SocialGetPostModelLoadinglState extends SocialStates{}
class SocialGetPostModelSuccessState extends SocialStates{}
class SocialGetPostModelErrorState extends SocialStates{
  String? error;
  SocialGetPostModelErrorState(this.error);

}
 //like

class SocialLikeSuccessState extends SocialStates{}
class SocialLikeErrorState extends SocialStates{
  String? error;
  SocialLikeErrorState(this.error);

}

//dislike
class SocialDisLikeSuccessState extends SocialStates{}
class SocialDisLikeErrorState extends SocialStates{
  String? error;
  SocialDisLikeErrorState(this.error);

}

// get all users
class SocialGetAllUsersLoadinglState extends SocialStates{}
class SocialGetAllUsersSuccessState extends SocialStates{}
class SocialGetAllUsersErrorState extends SocialStates{
  String? error;
  SocialGetAllUsersErrorState(this.error);

}




class SocialLikeOrErrorState extends SocialStates{
  String? error;
  SocialLikeOrErrorState(this.error);

}


class SocialBottomNavBarState extends SocialStates{}

class SocialPostState extends SocialStates{}

class SocialProfilePickedSuccessState extends SocialStates{}
class SocialProfilePickedErrorState extends SocialStates{}

class SocialCoverPickedSuccessState extends SocialStates{}
class SocialCoverPickedErrorState extends SocialStates{}

class SocialUpdateCoverSuccessState extends SocialStates{}
class SocialUpdateCoverErrorState extends SocialStates{}


class SocialUpdateProfileSuccessState extends SocialStates{}
class SocialUpdateProfileErrorState extends SocialStates{}

class SocialUpdateUserSuccessState extends SocialStates{}
class SocialUpdateUserErrorState extends SocialStates{}
class SocialUpdateUserLoading extends SocialStates{}
class SocialUpdateProfileLoading extends SocialStates{}
class SocialUpdateCoverLoading extends SocialStates{}

//create post

class SocialPostImagePickedSuccessState extends SocialStates{}
class SocialPostImagePickedErrorState extends SocialStates{}

class SocialUploadPostImageLoading extends SocialStates{}
class SocialUploadPostImageSuccessState extends SocialStates{}
class SocialUploadPostImageErrorState extends SocialStates{}

class SocialCreatePostLoading extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}

class SocialRemovePostImageState extends SocialStates{}

//chat

class SocialSendSuccessState extends SocialStates{}
class SocialSendErrorState extends SocialStates{}


class SocialGetChatSuccessState extends SocialStates{}
