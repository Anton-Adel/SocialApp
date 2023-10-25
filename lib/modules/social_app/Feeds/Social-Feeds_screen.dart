
import 'package:social_app/layout/social-app/social-app-cubit/social-app-cubit.dart';
import 'package:social_app/layout/social-app/social-app-cubit/social-app-states.dart';
import 'package:social_app/models/social-app/social-post-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialFeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=SocialLayoutCubit.get(context);
        return cubit.post.length>0 && cubit.model!=null? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                elevation: 15,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(8),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Image(
                      image: NetworkImage('https://img.freepik.com/free-psd/canvas-poster_176382-2259.jpg?w=740'),
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Communicate With Your Friends",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  itemBuilder: (context,index)=>PostBuilder(cubit.post[index],context,index), separatorBuilder: (context,index)=> SizedBox(
                height: 10,
              ), itemCount: cubit.post.length),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ):Center(child: CircularProgressIndicator());
      },

    );
  }

  Widget PostBuilder(SocialPostModel model,context,index)=>Card(
    elevation: 15,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${model.profile}',
                ) ,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${model.name}',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.black,
                            height: 1.4
                        ),

                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.check_circle,
                        color: Colors.blue,
                        size: 15,
                      )
                    ],
                  ),
                  Text('${model.dateTime}',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        height: 1.4
                    ),
                  ),

                ],


              ),

              ),

              IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz,
                size: 15,
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              color: Colors.grey[300],
              height: 1,
            ),
          ),
          Text('${model.text}',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Colors.black,
                height: 1.1
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 8.0),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Container(
          //           height: 25,
          //           child: MaterialButton(
          //             minWidth: 1,
          //             height: 25,
          //             padding: EdgeInsets.only(right: 5),
          //             onPressed: (){},
          //             child: Text("#software",
          //               style: Theme.of(context).textTheme.caption!.copyWith(
          //                 color: Colors.blue,
          //
          //               ),
          //             ),
          //
          //           ),
          //         ),
          //
          //       ],
          //     ),
          //   ),
          // ),

          if(model.postImage!='')
          Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: Card(

              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.zero,
              child: Image(
                image: NetworkImage('${model.postImage}'),
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Row(
                      children: [
                        Icon(Icons.volunteer_activism,
                          color: Colors.red,
                        ),

                        Text('${SocialLayoutCubit.get(context).PostLikes[index]}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),


                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Icon(Icons.chat,
                          color: Colors.red,
                        ),

                        Text('0',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              color: Colors.grey[300],
              height: 1,
            ),
          ),

          Row(
            children: [

              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Container(
                    decoration: BoxDecoration(

                        color: Colors.grey[200]
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                      backgroundImage: NetworkImage('${SocialLayoutCubit.get(context).model!.profile}', ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Write Your Comment',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(onPressed: (){
                SocialLayoutCubit.get(context).like_or(SocialLayoutCubit.get(context).PostId[index]);
              }, icon: Icon(Icons.volunteer_activism,
                color:   Colors.red,
              ),
                iconSize: 20,
              ),

            ],
          ),
        ],
      ),
    ),
  );
}
