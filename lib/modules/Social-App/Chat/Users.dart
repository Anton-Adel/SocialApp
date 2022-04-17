
import 'package:assignment3/Layout/Cubit.dart';
import 'package:assignment3/Layout/States.dart';
import 'package:assignment3/models/user_model.dart';
import 'package:assignment3/shared/cross-the-app/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ChatDetails/ChatDetails.dart';

class SocialChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<layoutCubit,LayoutState>
      (
      listener: (context,state){},
      builder: (context,state){

        return Scaffold(
          appBar: AppBar(
            title: Text("Connects"),
          ),
          body: layoutCubit.get(context).Users.length>0?ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>ChatItembuilder(context,layoutCubit.get(context).Users[index]),
              separatorBuilder:(context,index)=> SizedBox(height: 10 ,),
              itemCount: layoutCubit.get(context).Users.length):Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(child: Text("There is no friends to chat with.......",
          style: TextStyle(fontSize: 30,
          color: Colors.grey
          ),
          ),),
              ),
        );

      },
    );
  }
  Widget ChatItembuilder(context, UserModel model)=> InkWell(
    onTap: (){
     navigate(context, Chat_Screen(model: model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('${model.profile}',
            ) ,
          ),
          SizedBox(
            width: 15,
          ),
          Text('${model.name}',
           style: TextStyle(
             fontSize: 20
           ),
          ),
        ],
      ),
    ),
  );
}
