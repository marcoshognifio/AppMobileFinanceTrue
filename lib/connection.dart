

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'button.dart';
import 'data_class.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  State<HomePage> createState() => HomePageState();

}

class HomePageState extends State<HomePage> {

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
        backgroundColor: const Color(0xfff5f7f8),
        body: Stack(
          children: [
             Image.asset('images/AB2.png',width: 300),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Column(
                  children: [
                    Text("Connectez-vous",
                      style: GoogleFonts.abel(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontStyle: FontStyle.italic),),
                    SizedBox(
                      width: 400,
                      child: Column(
                        children: [
                          entryfield('votre email','email',RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'), emailController),
                          entryfield('votre mot de passe','password',RegExp(''), passwordController),
                          Column(
                            children: [
                              buttonWidget('Valider', actionFunction, context),
                              const Padding(
                                padding: EdgeInsets.only(top:10.0,right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                   Text("Vous n'avez pas de compte ?   "),
                                    Text('Inscrivez-vous',style: TextStyle(color: Colors.blueAccent),)
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )

                  ],
                )),
              ],
            )
          ]
        )
      );
  }

  Widget entryfield (String  text,String type,RegExp express,TextEditingController control) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, top: 15),
      child: TextFormField(

        controller: control,
        obscureText: type == 'password',
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hoverColor: Colors.white,
            prefixIcon: type == 'password'? const Icon(Icons.lock, color: Colors.blueAccent,):
                                            const Icon(Icons.email_outlined, color: Colors.blueAccent,),
            labelText: text,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none
                )
            )
        ),
        validator: (value) {
          if (value!.isEmpty || !express.hasMatch(value)) {
            return 'Ce champ est obligatoire';
          }
          else {
            return null;
          }
        },
      ),
    );
  }

}