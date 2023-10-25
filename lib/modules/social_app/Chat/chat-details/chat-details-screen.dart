
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../layout/social-app/social-app-cubit/social-app-cubit.dart';
import '../../../../layout/social-app/social-app-cubit/social-app-states.dart';
import '../../../../models/social-app/MassegeModel.dart';
import '../../../../models/social-app/social-user-model.dart';

class ChatScreen extends StatelessWidget {
var massegeController=TextEditingController();
SocialUserModel? model;
ChatScreen({this.model});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        SocialLayoutCubit.get(context).GetMasseges(receveruid: model!.uId!);
        return BlocConsumer<SocialLayoutCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${model!.profile}'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(model!.name!)
                  ],
                ),
              ),
              body:
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (contetx,index)
                      {
                        var massege=SocialLayoutCubit.get(context).masseges;
                        if(SocialLayoutCubit.get(context).model!.uId==massege[index].SenderuId)
                         return  BuildMyMassege(massege[index]);
                        else
                          {
                            return BuildMassege(massege[index]);
                          }
                      },
                          separatorBuilder: (context,index){
                        return SizedBox(height: 10,);
                          },
                          itemCount: SocialLayoutCubit.get(context).masseges.length),
                    ),


                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 1
                          ),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: massegeController,
                              decoration: InputDecoration(
                                hintText: 'Write your massege',
                                border: InputBorder.none,

                              ),
                            ),
                          ),
                          MaterialButton(onPressed: (){

                            SocialLayoutCubit.get(context).SendMassege(text: massegeController.text, receveruid: model!.uId!, date: DateTime.now().toString());
                            massegeController.text='';
                          },
                            minWidth: 0,

                            child: Icon(Icons.send),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              )


              ,

            );
          },

        );

      },
    );
  }

  Widget BuildMassege(MassegeModel model)=> Align(
    alignment: Alignment.topLeft,
    child: Container(
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )
        ),
        padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5
        ),
        child: Text("${model.Text}")),
  );
  Widget BuildMyMassege(MassegeModel model)=>Align(
alignment: Alignment.topRight,
child: Container(

decoration: BoxDecoration(
color: Colors.blue,
borderRadius: BorderRadius.only(
topLeft: Radius.circular(10),
topRight: Radius.circular(10),
bottomLeft: Radius.circular(10),
)
),
padding: EdgeInsets.symmetric(
vertical: 10,
horizontal: 5
),
child: Text("${model.Text}")),
);
}
