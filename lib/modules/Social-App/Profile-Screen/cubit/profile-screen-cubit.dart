// ignore: file_names
// ignore_for_file: file_names

import 'package:assignment3/modules/Social-App/Profile-Screen/cubit/profile-screen-state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfileCubit extends Cubit<ProfileStates>{
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context)=>BlocProvider.of(context);


}