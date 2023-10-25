
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social-app/social-app-cubit/social-app-cubit.dart';
import '../../../layout/social-app/social-app-cubit/social-app-states.dart';
import '../../../models/social-app/social-user-model.dart';
import '../../../shared/components/component.dart';
import 'chat-details/chat-details-screen.dart';

class SocialChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialStates>
      (
      listener: (context,state){},
      builder: (context,state){

        return SocialLayoutCubit.get(context).Users.length>0?ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>ChatItembuilder(context,SocialLayoutCubit.get(context).Users[index]),
            separatorBuilder:(context,index)=> seperator(),
            itemCount: SocialLayoutCubit.get(context).Users.length):Center(child: CircularProgressIndicator());

      },
    );
  }
  Widget ChatItembuilder(context, SocialUserModel model)=> InkWell(
    onTap: (){
      navigate(context, ChatScreen(model: model,));
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
            style: Theme.of(context).textTheme.bodyText1!.copyWith(

            ),
          ),
        ],
      ),
    ),
  );
}
