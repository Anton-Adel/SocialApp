import 'package:social_app/layout/social-app/social-app-cubit/social-app-states.dart';
import 'package:social_app/modules/social_app/edit-profile/Social-Edit-profile.dart';
import 'package:social_app/layout/social-app/social-app-cubit/social-app-cubit.dart';
import 'package:social_app/shared/components/component.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialLayoutCubit.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 210,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
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
                              image: NetworkImage(model!.cover!),
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            model.profile!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${model.name}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  '${model.bio}',
                  style:
                      Theme.of(context).textTheme.caption!.copyWith(height: 1.9),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                'Post',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(height: 1.9),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                'Post',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(height: 1.9),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '10K',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                'Follower',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(height: 1.9),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '80',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                'Following',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(height: 1.9),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {}, child: Text('Add Photos',
                        style: TextStyle(
                          color: Colors.grey
                        ),
                        ))

                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          navigate(context, Social_Edit_Profile());
                        }, child: Icon(Icons.edit,
                    color: Colors.black,
                    )
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                defaultButton(function: (){
                  SignOut(context);
                }, text: 'Sign out')
                //  defaultButton(function: (){}, text: 'Update Profile')
              ],
            ),
          ),
        );
      },
    );
  }
}
