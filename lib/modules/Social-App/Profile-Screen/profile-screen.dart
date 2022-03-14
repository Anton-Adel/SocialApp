// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: Padding(
        padding:  EdgeInsets.all( 8.0),
        child: Column(

          children: [
            Container(
              height: 265,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(9),
                  topEnd: Radius.circular(9),
                ),

              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image(image: AssetImage('assets/images/Facebook.png'),
                        width: double.infinity,
                        height: 190,
                        fit:BoxFit.cover

                    ),
                  ),
                  CircleAvatar(
                    radius: 68,
                    backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
                    child: CircleAvatar(
                        radius: 66,
                        backgroundImage: AssetImage('assets/images/Facebook.png')
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text('Anton Adel',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Bio......',
              style: TextStyle(
                color: Colors.grey,


              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [

                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        Text('100',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),

                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Posts')
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        Text('100',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),

                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Followers')
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        Text('100',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),

                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Following')
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        Text('100',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),

                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('# Tags')
                      ],
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.orange,
                    ),

                    child: MaterialButton(onPressed: (){},
                      child: Text('Add Post',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 10,
                ),
                Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orange,
                  ),
                  child: MaterialButton(onPressed: (){},
                    child: Icon(Icons.edit,
                      color: Colors.white,

                    ),
                    minWidth: 1,
                  ),

                ),
              ],
            ),

          ],
        ),
      ) ,
    );
  }
}
