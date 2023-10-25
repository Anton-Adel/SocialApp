
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social-app/social-app-cubit/social-app-cubit.dart';
import '../../../layout/social-app/social-app-cubit/social-app-states.dart';
import '../../../shared/components/component.dart';

class Social_Edit_Profile extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialLayoutCubit.get(context).model;
        var profileImage=SocialLayoutCubit.get(context).profileImage;
        var coverImage=SocialLayoutCubit.get(context).coverImage;
        nameController.text = model!.name!;
        phoneController.text = model.phone!;
        bioController.text = model.bio! ;
        print(bioController.text);
        return Scaffold(
            appBar: AppBar(
              title: Text('Edit'),
              titleSpacing: 0,
              actions: [TextButton(onPressed: () {
                SocialLayoutCubit.get(context).UpdateUserDate(name:  nameController.text, phone: phoneController.text, bio:  bioController.text);
                Navigator.pop(context);
              }, child: Text('Update'))],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if(state is SocialUpdateUserLoading)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 210,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
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
                                      image: coverImage != null? FileImage(coverImage) as ImageProvider:NetworkImage(
                                        model.cover!),
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialLayoutCubit.get(context).GetCoverImage();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                  ))
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60,

                                  backgroundImage: profileImage != null? FileImage(profileImage) as ImageProvider:NetworkImage(
                                    model.profile!,
                                  )  ,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialLayoutCubit.get(context).GetProfileImage();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                   if(SocialLayoutCubit.get(context).profileImage!=null||SocialLayoutCubit.get(context).coverImage!=null)
                    Row(
                      children: [
                        if(SocialLayoutCubit.get(context).profileImage!=null)
                       Expanded(
                         child: Column(
                           children: [
                             MaterialButton(onPressed: (){
                               SocialLayoutCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                             },child: Text('Upload profile', style: TextStyle(color: Colors.white),),color: Colors.grey,
                             height: 35,
                               minWidth: double.infinity,

                             ),
                             SizedBox(height: 5,),
                             if(state is SocialUpdateProfileLoading)
                             LinearProgressIndicator(),
                           ],
                         ),
                       ),
                        SizedBox(
                          width: 5,
                        ),
                        if(SocialLayoutCubit.get(context).coverImage!=null)
                        Expanded(
                          child: Column(
                            children: [
                              MaterialButton(onPressed: (){
                                SocialLayoutCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);

                              },child: Text('Upload Cover', style: TextStyle(color: Colors.white),),color: Colors.grey,
                                height: 35,
                                minWidth: double.infinity,

                              ),
                               SizedBox(height: 5,),
                              if(state is SocialUpdateCoverLoading)
                               LinearProgressIndicator(),
                            ],
                          ),
                        )

                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    DefaultTextFeild(
                        controller: nameController,
                        type: TextInputType.name,
                        label: 'Name',
                        prefix: Icons.person,
                        validate: (ss) {
                          if(ss.isEmpty())
                            {
                              return 'Name is empty';
                            }
                          else
                            return null;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    DefaultTextFeild(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'phone',
                        prefix: Icons.call,
                        validate: (ss) {
                          if(ss.isEmpty())
                          {
                            return 'phone is empty';
                          }
                          else
                            return null;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    DefaultTextFeild(
                        controller: bioController,
                        type: TextInputType.text,
                        label: 'Bio',
                        prefix: Icons.description,
                        validate: (ss) {
                          if(ss.isEmpty())
                          {
                            return 'Bio is empty';
                          }
                          else
                            return null;
                        }),

                  ],
                ),
              ),
            ));
      },
    );
  }
}
