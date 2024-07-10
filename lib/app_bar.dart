import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String menu;


  const AppBarWidget({super.key,  required this.menu});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Padding(
          padding: const EdgeInsets.only(top :8.0),
          child: Center(child: Image.asset('images/6.png',height: 50,)),
        ),
        leading:IconButton(
            icon: const  Icon(Icons.arrow_back_sharp,size: 40,color: Colors.white,),
            onPressed: () { Navigator.pop(context);},) ,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu,color: Colors.white,size: 40,),
            onPressed: (){
              print('bonjour');
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