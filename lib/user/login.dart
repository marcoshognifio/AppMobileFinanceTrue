
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
      print('bonjour');
      final uri = Uri.parse("$url/api/user/login");
      final response = await http.post(uri, body: request);
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['success'] == true) {
        currentUser = data['user'];
        token =data["token"];
        listCurrentProjects.add(currentProject);
        listRoutes.add('/user/projects_create');
        await Navigator.pushNamed(context, '/user/projects_create');
      }
      else{
        print(data['success']);
      }
    }
  }
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image:  AssetImage('images/bg1.png'),fit: BoxFit.cover)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                header(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 150.0),
                  child: content(),
                ),
              ],
            ),
          ),
        ),
    );
  }


  Widget content() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white.withOpacity(0.15),),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xff7a91f8).withOpacity(1),Colors.white.withOpacity(0.3)]
          )

      ),
      child: Column(
        children: [
          Center(child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 130,
                    width: 130,
                    child: Center(
                        child: Image.asset('images/Logo5.png', width: 130)),
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
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      EntryField(text:'votre email',type:  'email',
                          express: RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                          control: emailController,required:true,error:  'Entrez un email'),
                      EntryField(text: 'votre mot de passe',type: 'password',express: RegExp(''),
                          control:  passwordController,required: true,error:  ""),
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
                          ButtonWidget(text: 'Se connecter', onTap: actionFunction),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Pas de compte ?"),
                                TextButton(
                                    onPressed: () {Navigator.pushNamed(context, '/inscription');},
                                    child: const Text('Inscriver-vous',
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
      padding: const EdgeInsets.only(top:25,bottom: 20,left: 20,right: 20),
      margin: const EdgeInsets.all(15),
      child: const Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top:10, bottom: 10.0),
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
