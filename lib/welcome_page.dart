import 'dart:async';

import 'package:flutter/material.dart';

import 'button.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});



  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

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
                  loginButton("Se connecter", '/login' ,context),
                  loginButton("Inscription", '/inscription',context)
                ],
              ),

            )
          ],
        )
    );
  }
}


