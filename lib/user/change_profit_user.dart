import 'dart:convert';
import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import 'package:http/http.dart' as http;
import '../components/navbar_user.dart';

//ignore: must_be_immutable
class ChangeProfitUser extends StatefulWidget {
  ChangeProfitUser({super.key});

  String textError="";

  @override
  State<ChangeProfitUser> createState() => ChangeProfitUserState();
}

class ChangeProfitUserState extends State<ChangeProfitUser> {

  int a = 0;
  TextStyle textStyle = const TextStyle(
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
  @override
  void dispose() {
    super.dispose();
    nomController.dispose();
    telephoneController.dispose();
    emailController.dispose();
    passwordController.dispose();

  }

  actionFunction() async {
    if (formKey.currentState!.validate()) {

      final wordPassController=TextEditingController();
      showDialog(
          context: context,
          builder: (context) =>AlertDialog(
            title: const Text("Confirmer la modification de votre profit"),
            content:  Container(
              height: 100,
              child: Column(
                children: [
                  Text(widget.textError,style: const TextStyle(fontFamily: 'Roboto-Regular',color: Colors.redAccent)),
                  EntryField(text:  'Votre mot de passe',type: 'password',express: RegExp(r''),
                    control: wordPassController,required: true,error: 'Entrez votre mot de passe', icon: const Icon(Icons.lock),),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed:() async{
                    if(wordPassController.text.isNotEmpty) {
                      await editProfit(wordPassController.text);
                    }
                  },
                  child: const Text("Valider",style: TextStyle(fontFamily: 'Roboto-Regular',),)
              ),
              TextButton(onPressed:()async {
                Navigator.of(context).pop();
              }, child: const Text("Quitter",style: TextStyle(fontFamily: 'Roboto-Regular',),))
            ],
          )
      );
    }
  }

 editProfit(String text) async {

   Map<String, dynamic> user = {
     'email' : currentUser['email'],
     'password' :text
   };

   print(user);
   final uri = Uri.parse("$url/api/user/authentification");

   final response = await http.post(uri, body: jsonEncode(user),headers: {
     "Content-Type": "application/json",
     "Authorization": "Bearer $token"
   });

   Map<String, dynamic> data = json.decode(response.body);
   if (data['success'] == true) {

     user ={};
     nomController.text.isNotEmpty ?
      user['name'] = nomController.text :true == true;
     telephoneController.text.isNotEmpty?
      user['telephone'] = telephoneController.text :true == true;
     emailController.text.isNotEmpty ?
      user['email'] = emailController.text : true == true;
     passwordController.text.isNotEmpty ?
      user['password'] = passwordController.text : true == true;

     final uri = Uri.parse("$url/api/user/${currentUser['id']}/edit");
     final response = await http.post(uri, body: jsonEncode(user),
         headers: {
           "Content-Type": "application/json",
           "Authorization": "Bearer $token"
         });

     data = json.decode(response.body);
     if(data['success'] == true) {
       currentUser = data['user'];
       Navigator.pushNamed(context, '/user/profit');
     }
   }
   else {
     setState(() {
       widget.textError = "Mot de passe incorrect";
     });

   }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    nomController.text = currentUser['name'];
    telephoneController.text = currentUser['telephone'];
    emailController.text = currentUser['email'];
    return Scaffold(

        bottomNavigationBar: const NavbarUser(),
        appBar: const AppBarWidget(menu: '/menuUser'),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Modification du Profile Utilisateur ",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth*0.045,
                      fontStyle: FontStyle.italic),),
              ),
              Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      EntryFieldForm(text:  'Nouveau Nom (Facultatif)',type:  'text',express:  RegExp(r''),
                        control:  nomController,required:  false,error:  '', icon: const Icon(Icons.person),),
                      EntryFieldForm(text: 'Telephone (Facultatif)',type: 'text',express: RegExp(r'^[0-9]+$'),
                        control: telephoneController,required: false,error:  'Entrez des valeurs numeriques', icon: const Icon(Icons.numbers),),
                      EntryFieldForm(text:  'Email (Facultatif)', type: 'email',
                        express:  RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                        control:  emailController,required:  false,error:  '', icon: const Icon(Icons.email),),
                      EntryFieldForm(text:  'Nouveau Mot de Passe (Facultatif)',type:  'password',express:  RegExp(''),
                        control:  passwordController,required: false,error:  '', icon: const Icon(Icons.lock),),

                      ButtonWidget(text:'Valider', onTap: actionFunction),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

