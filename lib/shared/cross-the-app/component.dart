
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double? width=double.infinity,
  Color background= Colors.orangeAccent,
  bool? upper=true,
  double radius=0.0,
  required Function function,
  required String text,
}) => Container(
  width: width,
  decoration: BoxDecoration
    (
    borderRadius: BorderRadius.circular(radius),
    color:background,
  ),
  child: MaterialButton(onPressed:(){
    function();
  },
    height: 30,
    child: Text(
      upper!?text.toUpperCase():text,
      style: const TextStyle(fontSize: 20,
          color: Colors.white
      ),
    ),
  ),
);
Widget DefaultTextFeild({
  required TextEditingController controller,
  required TextInputType type,
  bool password=false,
  required String label,
  required IconData prefix,
  Function? onchange,
  Function? ontap,
  IconButton? suffix,
  required FormFieldValidator validate,
})=> TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: password,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix,
    border: OutlineInputBorder(),
  ),
  validator: validate,
  onChanged: (value){
    onchange!(value);
  },
  onTap: (){
    ontap!();
  },

);


void navigate (context,Widget)=>Navigator.push(context,
    MaterialPageRoute(builder: (context)=>Widget)
);



// void showTost(String mas,TostStatus state)=>
//     Fluttertoast.showToast(
//     msg: mas,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: TostColor(state),
//     textColor: Colors.white,
//     fontSize: 16.0
// );
//
// enum TostStatus {SUCCESS,ERROR,WARING}
//
// Color TostColor(TostStatus state){
//   Color? c;
//   switch(state)
//   {
//     case TostStatus.SUCCESS:
//       c=Colors.green;
//       break;
//     case TostStatus.ERROR:
//       c=Colors.red;
//       break;
//     case TostStatus.WARING:
//       c=Colors.amber;
//       break;
//   }
//   return c;
//
//
// }

