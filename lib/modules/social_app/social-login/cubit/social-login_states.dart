
import 'package:social_app/models/social-app/social-user-model.dart';

abstract class SocialAppStates{}

class SocialAppInitialState extends SocialAppStates{}

class SocialAppLoadinglState extends SocialAppStates{}
class SocialAppSuccessState extends SocialAppStates{
  String? uId;
  SocialAppSuccessState(this.uId);

}
class SocialAppErrorState extends SocialAppStates{

   String? error;
  SocialAppErrorState(this.error);

}

class SocialApppasswordVisiability extends SocialAppStates{}

