
import 'package:flutter/material.dart';

class NavbarUser extends StatelessWidget {
  const NavbarUser({super.key});
  final TextStyle textStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 15)   ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  height: 30,
                  child: IconButton(
                    icon: const Icon(Icons.home, color: Colors.white),
                    onPressed: () {Navigator.pushNamed(context, '/user/projects_create');},
                  ),
                ),
                Text('Projets créés',style: textStyle,)
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: const EdgeInsets.all(0),
                    height: 30,
                     child: IconButton(
                       icon: const Icon(Icons.home, color: Colors.white),
                       onPressed: () {Navigator.pushNamed(context, '/user/projects_admin');},
                     ), )  ,

                Text('Projets administrés',style: textStyle,)
              ],
            )
          ],
        )

    );//
  }
}
