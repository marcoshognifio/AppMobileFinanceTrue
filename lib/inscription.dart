import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_memoire/get_image.dart';
import 'dart:convert';
import 'entre.dart';
import 'data_class.dart';


class Inscription extends StatefulWidget {
  const Inscription({super.key});



  @override
  State<Inscription> createState() => _LoginState();
}

class _LoginState extends State<Inscription> {

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
  final nomController=TextEditingController();
  final telephoneController = TextEditingController();
  final emailController=TextEditingController();
  final passwordController = TextEditingController();
  late GetImage imageController ;

  @override
  void dispose() {
    super.dispose();
    nomController.dispose();
    telephoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
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
                    entryfield('Nom','text',RegExp(r''), nomController),
                    entryfield('telephone','text',RegExp(''), telephoneController),
                    entryfield('Email','email',RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'), emailController),
                    entryfield('Mot de pase','text',RegExp(''), passwordController),
                    imageController = GetImage(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              //fixedSize: const Size(350, 40),
                                elevation: 5,
                                backgroundColor: Colors.blue
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {

                                Map<String,dynamic> request = {
                                  'name' : nomController.text,
                                  'telephone' : telephoneController.text,
                                  'email' : emailController.text,
                                  'password' : passwordController.text,
                                  'image' : imageController.getNameImage()
                                };

                                print(request);
                                final uri = Uri.parse("$url/api/user/save_user");
                                final response = await http.post(uri,body : request);
                                print(response.body);

                                final Map<String, dynamic> data = json.decode(response.body);

                                //Navigator.pushNamed(context,'/user/projects',arguments: data['user']['id']);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text('Valider',style: textStyle),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ]
              ),
            )
        ),
      ),
    );

  }

}






































