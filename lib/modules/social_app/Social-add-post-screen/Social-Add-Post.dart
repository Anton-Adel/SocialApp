
import 'package:social_app/layout/social-app/social-app-cubit/social-app-cubit.dart';
import 'package:social_app/layout/social-app/social-app-cubit/social-app-states.dart';
import 'package:social_app/shared/components/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Social_Add_Post extends StatelessWidget {

var TextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed:(){
              Navigator.pop(context);
            },
                icon:Icon(Icons.arrow_back_ios)),
            titleSpacing: 0,
            title: Text('Create Post'),
            actions: [
              TextButton(onPressed: (){
                var now=DateTime.now();

                if(SocialLayoutCubit.get(context).PostImage==null && TextController.text!='')
                  {

                    SocialLayoutCubit.get(context).CreatePost(text: TextController.text, dataTime: now.toString());
                    Navigator.pop(context);
                  }
                else if(SocialLayoutCubit.get(context).PostImage!=null)
                  {
                      SocialLayoutCubit.get(context).uploadPostImage(text: TextController.text, dataTime: now.toString());
                    Navigator.pop(context);
                  }
                else{
                  showTost('There is no post to publish', TostStatus.WARING);

                  Navigator.pop(context);
                }
              }, child: Text("Post"))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoading)
                  LinearProgressIndicator(),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('${SocialLayoutCubit.get(context).model!.profile}',                ) ,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(child: Text('Anton Adel',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.black,
                          height: 1.4
                      ),

                    ),

                    ),

                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: TextController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Write what on your mind....',
                      border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if(SocialLayoutCubit.get(context).PostImage!=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Card(
                          //clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: EdgeInsets.zero,
                          child: Image(
                            image: FileImage(SocialLayoutCubit.get(context).PostImage!),
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          SocialLayoutCubit.get(context).RemovePostImage();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors. black,

                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialLayoutCubit.get(context).GetPostImage();
                      },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image),
                              Text('add photo')
                            ],
                              ),
                      ),
                    ),

                    Expanded(child: TextButton(onPressed: (){},
                      child: Text('# tags'),
                    ),),
                  ],
                ),

              ],
            ),
          ),

        );
      },
    );
  }
}
