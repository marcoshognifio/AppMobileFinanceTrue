import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String menu;


  const AppBarWidget({super.key,  required this.menu});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(
              5.0,
              5.0,
            ), //Offset
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Color(0xff363636),
            offset: Offset(0.0, 0.0),
            blurRadius: 5.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      child: AppBar(
          backgroundColor: Colors.blueAccent,
          title:Center(child: Image.asset('images/6.png',height: 50,)),

          leading:IconButton(
              icon: const  Icon(Icons.arrow_back_sharp,size: 40,color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);},) ,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu,color: Colors.white,size: 40,),
              onPressed: (){
                Navigator.pushNamed(context,menu);
              }
            )
          ],
        ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
}