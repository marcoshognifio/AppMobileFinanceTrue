import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_memoire/project/get_list.dart';
import 'package:projet_memoire/components/navbar_user.dart';
import 'dart:convert';
import 'package:projet_memoire/components/app_bar.dart';
import 'package:projet_memoire/components/components.dart';
import 'package:projet_memoire/components/data_class.dart';

import '../components/button.dart';


class ChangeAdminProject extends StatefulWidget {
  const ChangeAdminProject({super.key});

  @override
  State<ChangeAdminProject> createState() => ChangeAdminProjectState();
}

class ChangeAdminProjectState extends State<ChangeAdminProject> {

  int a = 0;
  TextStyle textStyle = const TextStyle(
      color: Colors.white,
      height: 2,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      wordSpacing: 10,
      letterSpacing: 3
  );

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  late int projectController;

  late GetList getProjectRecipient;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }


  actionFunction() async {
    if (formKey.currentState!.validate()) {
      projectController = getProjectRecipient.getSelectedValue();
      Map<String, dynamic> request = {
        'email': emailController.text,

      };

      final uri = Uri.parse("$url/api/user/search");


      final response = await http.post(uri, body: jsonEncode(request),
          headers: {"Content-Type": "application/json","Authorization":"Bearer $token"});
      Map<String, dynamic> data = json.decode(response.body);

      return data;
    }
    else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const NavbarUser(),
        appBar: const AppBarWidget(menu: '/menuProject'),
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
                      getProjectRecipient = GetList(
                          items: DataClass().getItemsProjectsCreate()),
                      EntryField(text: 'Email du nouveau administrateur',
                          type: 'text',
                          express: RegExp(
                              r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                          control: emailController,
                          required: true,
                          error: 'Veillez entrer un email'),

                      ButtonWidget(text: 'Valider',onTap: ()async{

                        Map<String,dynamic> data = await actionFunction();

                        if(data['success'] == true ){

                          await showDialog(
                              context: context,
                              builder: (context) =>AlertDialog(
                                title: const Text("Confirmation de l'administrateur"),
                                content:  Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      const Text('Voulez vous confirmer comme administrateur'),
                                      Text("${data['user']['nom']} d'email ${data['user']['email']} ?")
                                    ],
                                  ),
                                ),
                                actions: [

                                  TextButton(onPressed:() async{
                                    Map<String,dynamic>  user = {
                                      'user_id': data['user']['id'],
                                    };
                                    final uri = Uri.parse("$url/api/projet/$projectController/change_admin");
                                    final response = await http.post(uri,body : jsonEncode(user),
                                        headers: {"Content-Type": "application/json","Authorization":"Bearer $token"});
                                    data = json.decode(response.body);
                                    if(data['success'] == true ){
                                      await Navigator.pushNamed(context, '/user/projects_create');
                                    }
                                  }, child: const Text("Valider")),

                                  TextButton(onPressed:()async {
                                    Navigator.of(context).pop();
                                  }, child: const Text("Quitter"))
                                ],
                              )
                          );

                        }

                      }),

                    ]
                ),
              )
          ),
        )
    );
  }

}