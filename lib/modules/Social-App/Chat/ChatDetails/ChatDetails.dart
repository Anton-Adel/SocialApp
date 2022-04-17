

import 'package:assignment3/Layout/Cubit.dart';
import 'package:assignment3/Layout/States.dart';
import 'package:assignment3/models/MassegeModel.dart';
import 'package:assignment3/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Chat_Screen extends StatelessWidget {
  var massegeController=TextEditingController();
  UserModel? model;
  Chat_Screen({this.model});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        layoutCubit.get(context).GetMasseges(receveruid: model!.uid!);
        return   BlocConsumer<layoutCubit,LayoutState>(
          listener: (context,state){},
          builder: (context,state){
            return    Scaffold(
              appBar: AppBar(
                  leading:
                  IconButton(
                    icon: Icon(
                        Icons.keyboard_return_outlined),
                    onPressed: (
                        ){
                      Navigator.pop(context);
                    },
                  ),
                  title: Row(
                    children:  [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage("${model!.profile}"),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        model!.name!,
                      )
                    ],
                  )
              ),
              body: Padding(
                padding:  EdgeInsets.all(20.0),
                child: Column(
                  children: [


                    Expanded(child: ListView.separated(itemBuilder: (context,index){
                      if(layoutCubit.get(context).masseges[index].SenderuId==layoutCubit.get(context).model!.uid)
                        {
                         return Sender(layoutCubit.get(context).masseges[index]);
                        }
                      else
                        {
                          return Reciver(layoutCubit.get(context).masseges[index]);
                        }
                    },
                        separatorBuilder: (context,index)=>SizedBox(height: 10,),
                        itemCount: layoutCubit.get(context).masseges.length)),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: massegeController ,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type here ...',

                              ),
                            ),
                          ),
                          Container(
                            child: MaterialButton(
                              onPressed: (){
                                layoutCubit.get(context).GetImage();
                              },
                              minWidth: 1.0,
                              child: Icon(
                                Icons.camera_alt,
                                size: 20.0,

                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            height: 50.0,
                            color: Colors.deepPurpleAccent,
                            child: MaterialButton(
                              onPressed: (){
                                if(layoutCubit.get(context).Image!=null)
                                {
                                  layoutCubit.get(context).uploadImage(text: massegeController.text, receveruid: model!.uid!, date: DateTime.now().toString());
                                  massegeController.text='';
                                }
                                else if( massegeController.text!='')
                                {
                                  layoutCubit.get(context).SendMassege(text: massegeController.text, receveruid: model!.uid!, date: DateTime.now().toString());
                                  massegeController.text='';
                                }
                                else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Empty Massege")));
                                }

                              },
                              minWidth: 1.0,
                              child: Icon(
                                Icons.send,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    if(layoutCubit.get(context).Image!=null)
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
                                  image: FileImage(layoutCubit.get(context).Image!),
                                  fit: BoxFit.cover,
                                  height: 60,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                layoutCubit.get(context).RemovePostImage();
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors. black,

                              ))
                        ],
                      ),
                  ],
                ),
              ),
            );
          },

        );
      },

    );
  }
  Widget Sender(MassegeModel model)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        if(model.Text!='')
        Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              )
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
              '${model.Text}'
          ),
        ),
        if(model.image!='')
        Card(
          //clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.zero,
          child: Image(
            image: NetworkImage("${model.image}"),
            fit: BoxFit.cover,
            height: 60,
            width: 200,
          ),
        ),

      ],
    ),
  );
  Widget Reciver(MassegeModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(model.Text!='')
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              )
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
              '${model.Text}'
          ),
        ),
        if(model.image!='')
          Card(
            //clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.zero,
            child: Image(
              image: NetworkImage("${model.image}"),
              fit: BoxFit.cover,
              height: 60,
              width: 200,
            ),
          ),
      ],
    ),
  );
}
