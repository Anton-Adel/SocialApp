// ignore: file_names
// ignore_for_file: file_names

abstract class RegisterState{}
class RegisterInitialSate extends RegisterState{}
class RegisterPassWordVisibleSate extends RegisterState{}
class RegisterChangeRadioSate extends RegisterState{}
//SignUp
class RegisterSignUpSuccessState extends RegisterState{
  String?uId;
  RegisterSignUpSuccessState(this.uId);
}
class RegisterSignUpErrorState extends RegisterState{
  String?error;
  RegisterSignUpErrorState(this.error);
}
class RegisterSignUpLoading extends RegisterState{}



