

abstract class SocialRegisterStates{}

class SocialRegisterInitialState extends SocialRegisterStates{}

class SocialRegisterLoadinglState extends SocialRegisterStates{}
class SocialRegisterSuccessState extends SocialRegisterStates{
  String? uId;
  SocialRegisterSuccessState(this.uId);
}
class SocialRegisterErrorState extends SocialRegisterStates{

  String? error;
  SocialRegisterErrorState(error);

}
class SocialCreateUserSuccessState extends SocialRegisterStates{}
class SocialCreateUserErrorState extends SocialRegisterStates{

  String? error;
  SocialCreateUserErrorState(error);
}

class SocialRegisterpasswordVisiability extends SocialRegisterStates{}

