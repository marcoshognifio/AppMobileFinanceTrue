import 'dart:async';

import 'package:flutter/material.dart';

import 'package:projet_memoire/components/button.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});



  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  actionLogin() {

        Navigator.pushNamed(context,'/login');
  }

  actionInscription() {

    Navigator.pushNamed(context,'/inscription');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    margin: const EdgeInsets.only(bottom: 30),
                      elevation:5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(300)),
                      child: Image.asset('images/6.png',width: 200)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0,right: 50.0,bottom: 20),
                    child: buttonWidget("Se connecter",actionLogin,context),
                  ),
                 Padding(
                   padding: const EdgeInsets.only(left: 50.0,right: 50.0,bottom: 20),
                   child: buttonWidget("Inscription",actionInscription,context),
                 )
                ],
              ),

            )
          ],
        )
    );
  }
}


