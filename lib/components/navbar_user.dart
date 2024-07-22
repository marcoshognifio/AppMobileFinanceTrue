

import 'dart:ui';

import 'package:flutter/material.dart';

class NavbarUser extends StatelessWidget {
  NavbarUser({super.key});
  TextStyle textStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20)   ;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
         color: Colors.blueAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(
              5.0,
              5.0,
            ), //Offset
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Color(0xff363636),
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
        ),
        height: 70.0, // Hauteur typique de la barre de navigation// Hauteur typique de la barre de navigation
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.home, color: Colors.white),
                  onPressed: () {Navigator.pushNamed(context, '/user/projects_create');},
                ),
                Text('Projets créés',style: textStyle,)
              ],
            ),

            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.home, color: Colors.white),
                  onPressed: () {Navigator.pushNamed(context, '/user/projects_admin');},
                ),
                const Text('Projets administrés')
              ],
            )
          ],
        )

    );//
  }
}
