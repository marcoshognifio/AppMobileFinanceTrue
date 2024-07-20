import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:projet_memoire/get_image.dart';
import 'dart:convert';
import 'button.dart';
import 'components.dart';
import 'data_class.dart';


class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => InscriptionPageState();
}

class InscriptionPageState extends State<InscriptionPage> {

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

  actionFunction() async{

    if (formKey.currentState!.validate()) {

      Map<String,dynamic> request = {
        'name' : nomController.text,
        'telephone' : telephoneController.text,
        'email' : emailController.text,
        'password' : passwordController.text,
        'image' : imageController.getNameImage()
      };

      final uri = Uri.parse("$url/api/user/save_user");
      final response = await http.post(uri,body : request);
      print(response.body);

      final Map<String, dynamic> data = json.decode(response.body);

      //Navigator.pushNamed(context,'/user/projects',arguments: data['user']['id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    height: 100,
                    width: 100,
                    child: Center(
                        child: Image.asset('images/Logo5.png', width: 100)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Inscrivez vous pour bénéficier des services de notre application",
                      style: GoogleFonts.actor(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          fontStyle: FontStyle.italic),),
                  ),
                ],
              ),
              SizedBox(
                child: Column(
                  children: [
                    entryField('Nom','text',RegExp(r''), nomController),
                    entryField('telephone','text',RegExp(''), telephoneController),
                    entryField('votre email', 'email',
                        RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                        emailController),
                    entryField('votre mot de passe', 'password', RegExp(''),
                        passwordController),

                    Column(
                      children: [
                        buttonWidget('S\'inscrire', actionFunction, context),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Avez vous un compte ?   "),
                              TextButton(
                                  onPressed: () {DefaultTabController.of(context).animateTo(0);},
                                  child: const Text('Connectez-vous',
                                    style: TextStyle(
                                        color: Colors.blueAccent),))
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
                padding: EdgeInsets.all(15.0),
                child: Text('Inscrivez-vous',
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






































