import 'package:social_app/layout/social-app/social-app-cubit/social-app-cubit.dart';
import 'package:social_app/layout/social-app/social-app-cubit/social-app-states.dart';
import 'package:social_app/modules/social_app/Social-add-post-screen/Social-Add-Post.dart';
import 'package:social_app/shared/components/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialPostState)
          {
            navigate(context, Social_Add_Post());

          }
      },
      builder: (context,state){
        var cubit=SocialLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.notification_important)),
              IconButton(onPressed: (){}, icon: Icon(Icons.search)),


            ],
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

            onTap: (index){
              cubit.ChangeScreen(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),
              label: 'Home'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.chat),
                  label: 'Chat'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.post_add),
                  label: 'Post'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.group),
                  label: 'Users'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.settings),
                  label: 'Setting'
              ),
            ],
          ),

        );
      },

    );
  }
}
