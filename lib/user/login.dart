
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:projet_memoire/components/button.dart';
import 'package:projet_memoire/components/components.dart';
import 'package:projet_memoire/components/data_class.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }

}

class LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<LoginPageState> myWidgetKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  actionFunction() async {
    if(formKey.currentState!.validate()) {
      Map<String, dynamic> request = {
        'email': emailController.text,
        'password': passwordController.text
      };
      final uri = Uri.parse("$url/api/user/login");

      final response = await http.post(uri, body: request);
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['success'] == true) {
        currentUser = data['user'];
       await DataClass().getProjectsUser(currentUser['id']);
        await Navigator.pushNamed(context, '/user/projects_create');
      }
    }
  }
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image:  AssetImage('images/bg1.png'),fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            header(),
            content(),
          ],
        ),
      );
  }

  Widget content() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white.withOpacity(0.15),),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight, 
            colors: [Colors.white.withOpacity(0.5),Colors.white.withOpacity(0.5)]
          )

      ),
      child: Column(
        children: [
          Center(child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Center(
                        child: Image.asset('images/Logo5.png', width: 150)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Connectez vous pour accéder à vos projets si vous avez un compte",
                      style: GoogleFonts.actor(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          fontStyle: FontStyle.italic),),
                  ),
                ],
              ),
              SizedBox(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      entryField('votre email', 'email',
                          RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                          emailController),
                      entryField('votre mot de passe', 'password', RegExp(''),
                          passwordController),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Mot de passe oublé ?   ",
                                style: TextStyle(color: Colors.blueAccent)),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          buttonWidget('Se connecter', actionFunction, context),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Vous n'avez pas de compte ?   "),
                                TextButton(
                                    onPressed: () {DefaultTabController.of(context).animateTo(1);},
                                    child: const Text('Inscriber-vous',
                                      style: TextStyle(
                                          color: Colors.blueAccent),))
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )

            ],
          )),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: const Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top:50, bottom: 10.0),
            child: Row(children: [
              Icon(Icons.label_important, color: Colors.white,),
              Padding(
                padding:  EdgeInsets.all(15.0),
                child: Text('Connectez-vous',
                  style:
                  TextStyle(color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),),
              )
            ],),
          ),
        ],
      ),
    );
  }
}
