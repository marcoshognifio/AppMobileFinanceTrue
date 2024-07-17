import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_memoire/button.dart';
import 'dart:convert';
import 'data_class.dart';
import 'entre.dart';


class Login extends StatefulWidget {
  const Login({super.key});



  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  int a=0;
  TextStyle textStyle=const TextStyle(
      color: Colors.white,
      height: 2,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      wordSpacing: 10,
      letterSpacing: 3
  );

  final formKey=GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  actionFunction() async{
      if (formKey.currentState!.validate()) {

        Map<String,dynamic> request = {
          'email' : emailController.text,
          'password' : passwordController.text
        };

        final uri = Uri.parse("$url/api/user/login");
        final response = await http.post(uri,body : request);
        final Map<String, dynamic> data = json.decode(response.body);
        if(data['success'] == true){
          currentUser = data['user'];
          Navigator.pushNamed(context,'/user/projects');
        }

      }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,
      body: Center(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    entryfield('votre email','email',RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'), emailController),
                    entryfield('votre mot de passe','password',RegExp(''), passwordController),
                    buttonWidget('Valider', actionFunction, context)
                  ]
              ),
            )
        ),
      ),
    );

  }

}