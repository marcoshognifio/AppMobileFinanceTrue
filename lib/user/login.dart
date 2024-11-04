
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:true_finance/components/button.dart';
import 'package:true_finance/components/components.dart';
import 'package:true_finance/components/data_class.dart';

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
  bool _isLoading = false;

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

      setState(() {
        _isLoading = true;
      });

      final uri = Uri.parse("$url/api/user/login");
      final response = await http.post(uri, body: request);
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        _isLoading = false;
      });
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

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return  Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          decoration: BoxDecoration(
            image:DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
                    BlendMode.darken),
                image: const AssetImage('assets/images/background.jpg'),
                fit: BoxFit.fill),

          ),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              SizedBox(
                width: screenWidth - 70,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Text("Bienvenu sur Finance True",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontSize: screenWidth*0.06,
                          wordSpacing: 5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Connectez vous afin de gérer vos projets",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ],
                  ),
                ),
              )
             ,
              Center( child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  content(),
                ],
              )),
              if(_isLoading )
                const Align(

                  child: Center(
                      child: CircularProgressIndicator()
                  ),
                )


            ],
          )
      ),
    );
  }

  Widget content(){

    return Container(
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                EntryField(text:'votre email',type:  'email',
                  express: RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                  control: emailController,required:true,error:  'Entrez un email', icon: const Icon(Icons.email),),
                EntryField(text: 'votre mot de passe',type: 'password',express: RegExp(''),
                  control:  passwordController,required: true,error:  "", icon: const Icon(Icons.lock),),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10, right: 30,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Mot de passe oublé ?   ",
                          style: TextStyle(fontFamily:"Roboto",color: Colors.blueAccent)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ButtonWidget(text: 'Se connecter', onTap: actionFunction),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Pas de compte ?",style: TextStyle(fontFamily:"Roboto",color: Colors.white),),
              TextButton(
                  onPressed: () {Navigator.pushNamed(context, '/inscription');},
                  child: const Text('Inscriver-vous',
                    style: TextStyle(
                        fontFamily: "Roboto",
                        color: Colors.blueAccent),))
            ],
          )
        ],
      ),
    );
  }
}
