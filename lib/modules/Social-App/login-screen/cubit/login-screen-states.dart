// ignore: file_names
// ignore_for_file: file_names

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginPasswordVisibleState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  String?uId;
  LoginSuccessState(this.uId);
}
class LoginErrorState extends LoginStates{
  String?error;
  LoginErrorState(this.error);
}
class LoginLoading extends LoginStates{}

