 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/styles/colors.dart';

 Widget defaultButton({
   double width = double.infinity,
   Color background = Colors.blue,
   bool isUpperCase = true,
   double radius = 3.0,
   @required Function function,
   @required String text,
 }) =>
     Container(
       width: width,
       height: 50.0,
       child: MaterialButton(
         onPressed: function,
         child: Text(
           isUpperCase ? text.toUpperCase() : text,
           style: TextStyle(
             color: Colors.white,
           ),
         ),
       ),
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(
           radius,
         ),
         color: background,
       ),
     );

 Widget defaultTextButton({
   @required Function function,
   @required String text,
 }) =>
     TextButton(
       onPressed: function,
       child: Text(
         text.toUpperCase(),
       ),
     );

 Widget defaultFormField({
   @required TextEditingController controller,
   @required TextInputType type,
   Function onSubmit,
   Function onChange,
   Function onTap,
   bool isPassword = false,
   @required Function validate,
   @required String label,
   @required IconData prefix,
   IconData suffix,
   Function suffixPressed,
   bool isClickable = true,
 }) =>
     TextFormField(
       controller: controller,
       keyboardType: type,
       obscureText: isPassword,
       enabled: isClickable,
       onFieldSubmitted: onSubmit,
       onChanged: onChange,
       onTap: onTap,
       validator: validate,
       decoration: InputDecoration(
         labelText: label,
         prefixIcon: Icon(
           prefix,
         ),
         suffixIcon: suffix != null
             ? IconButton(
           onPressed: suffixPressed,
           icon: Icon(
             suffix,
           ),
         )
             : null,
         border: OutlineInputBorder(),
       ),
     );

 Widget myDivider() => Padding(
   padding: const EdgeInsetsDirectional.only(
     start: 20.0,
   ),
   child: Container(
     width: double.infinity,
     height: 1.0,
     color: Colors.grey[300],
   ),
 );

 void navigateTo(context, widget) => Navigator.push(
   context,
   MaterialPageRoute(
     builder: (context) => widget,
   ),
 );

 void navigateAndFinish(
     context,
     widget,
     ) =>
     Navigator.pushAndRemoveUntil(
       context,
       MaterialPageRoute(
         builder: (context) => widget,
       ), (route) {
         return false;
       },
     );


 void showToast({
   @required String text,
   @required ToastStates state,
 }) =>
     Fluttertoast.showToast(
       msg: text,
       toastLength: Toast.LENGTH_LONG,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 5,
       backgroundColor: chooseToastColor(state),
       textColor: Colors.white,
       fontSize: 16.0,
     );

 // enum
 enum ToastStates {SUCCESS, ERROR, WARNING}

 Color chooseToastColor(ToastStates state)
 {
   Color color;

   switch(state)
   {
     case ToastStates.SUCCESS:
       color = Colors.green;
       break;
     case ToastStates.ERROR:
       color = Colors.red;
       break;
     case ToastStates.WARNING:
       color = Colors.amber;
       break;
   }

   return color;
 }


 Widget buildListProduct(
     model,
     context, {
       bool isOldPrice = true,
     }) =>
     Padding(
       padding: const EdgeInsets.all(20.0),
       child: Container(
         height: 120.0,
         child: Row(
           children: [
             Stack(
               alignment: AlignmentDirectional.bottomStart,
               children: [
                 Image(
                   image: NetworkImage(model.image),
                   width: 120.0,
                   height: 120.0,
                 ),
                 if (model.discount != 0 && isOldPrice)
                   Container(
                     color: Colors.red,
                     padding: EdgeInsets.symmetric(
                       horizontal: 5.0,
                     ),
                     child: Text(
                       'DISCOUNT',
                       style: TextStyle(
                         fontSize: 8.0,
                         color: Colors.white,
                       ),
                     ),
                   ),
               ],
             ),
             SizedBox(
               width: 20.0,
             ),
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     model.name,
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                     style: TextStyle(
                       fontSize: 14.0,
                       height: 1.3,
                     ),
                   ),
                   Spacer(),
                   Row(
                     children: [
                       Text(
                         model.price.toString(),
                         style: TextStyle(
                           fontSize: 12.0,
                           color: defaultColor,
                         ),
                       ),
                       SizedBox(
                         width: 5.0,
                       ),
                       if (model.discount != 0 && isOldPrice)
                         Text(
                           model.oldPrice.toString(),
                           style: TextStyle(
                             fontSize: 10.0,
                             color: Colors.grey,
                             decoration: TextDecoration.lineThrough,
                           ),
                         ),
                       Spacer(),
                       IconButton(
                         onPressed: () {
                           ShopCubit.get(context).changeFavorites(model.id);
                         },
                         icon: CircleAvatar(
                           radius: 15.0,
                           backgroundColor:
                           ShopCubit.get(context).favorites[model.id]
                               ? defaultColor
                               : Colors.grey,
                           child: Icon(
                             Icons.favorite_border,
                             size: 14.0,
                             color: Colors.white,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
     );
