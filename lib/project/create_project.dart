import 'dart:convert';

import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import 'package:http/http.dart' as http;

import '../components/navbar_user.dart';

//ignore: must_be_immutable
class AddProject extends StatefulWidget {
  AddProject({super.key,required this.hasParent});
  bool hasParent;


  @override
  State<AddProject> createState() => AddProjectState();
}

class AddProjectState extends State<AddProject> {

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
  final nomController = TextEditingController();
  final descriptionController = TextEditingController();
  final budgetController = TextEditingController();

  //final imageController=TextEditingController();
  final dateEndController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nomController.dispose();
    descriptionController.dispose();
    budgetController.dispose();
    dateEndController.dispose();
    emailController.dispose();
  }

  actionFunction(int admin) async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> project = {};
      project['nom'] = nomController.text;
      descriptionController.text.isNotEmpty ?
      project['description'] = descriptionController.text : true == true;
      budgetController.text.isNotEmpty ?
      project['budget_prevu'] = budgetController.text : true == true;
      dateEndController.text.isNotEmpty ?
      project['date_fin'] = dateEndController.text : true == true;

      if (widget.hasParent == true) {
        project['createur_id'] = currentProject['administrateur']['id'];
        project['administrateur_id'] = currentProject['administrateur']['id'];
        project['projet_parent_id'] = currentProject['id'];
      }
      else {
        project['createur_id'] = currentUser['id'];
        project['administrateur_id'] = admin;
      }

      final uri = Uri.parse("$url/api/projet/create_projet");
      final response = await http.post(uri, body: jsonEncode(project),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });

      final Map<String, dynamic> data = json.decode(response.body);

      if(data['success'] == true) {
        Navigator.pushNamed(context, '/user/projects_create');
      }
    }
  }

  searchUser() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> request = {
        'email': emailController.text,

      };

      final uri = Uri.parse("$url/api/user/search");

      final response = await http.post(uri, body: jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      Map<String, dynamic> data = json.decode(response.body);

      return data;
    }
    else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        bottomNavigationBar: const NavbarUser(),
        appBar: const AppBarWidget(menu: '/menuUser'),
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                header("Création d'un Project"),
                content("Ajouter un Projet pour gérer vos finances",
                    SizedBox(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            EntryField( text: 'Nom du projet',type: 'text',express:  RegExp(r'^[a-zA-Z][a-zA-Z0-9 ]+$'),
                                control: nomController,required: true,error: 'Entre invalide'),
                            EntryField( text: 'Description du projet(Facultative)',type:  'text',express:  RegExp(''),
                                control:  descriptionController,required: false,error: ''),
                            EntryField(text:  'Le budget prevu(Facultative)',type:  'text',express: RegExp(r'^[0-9]+(.)?[0-9]+$'),
                                control: budgetController,required: false,error:  'Entrez une valeur numerique'),
                            EntryField(text: 'Date fin projet(Facultative)',type: 'date',express: RegExp(''),
                                control: dateEndController,required: false,error:  ''),
                            EntryField(text: 'Email du nouveau administrateur',
                                type: 'text',
                                express: RegExp(
                                    r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                                control: emailController,
                                required: true,
                                error: 'Veillez entrer un email'),
                            ButtonWidget(text:'Se connecter',onTap: ()async{

                              Map<String,dynamic> data = await searchUser();

                              if(data['success'] == true ){

                                await showDialog(
                                    context: context,
                                    builder: (context) =>AlertDialog(
                                      title: const Text("Confirmation de creation de projet"),
                                      content:  Container(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            Text('Voulez vous confirmer la creation du projet ${nomController.text} ayant pour administrateur}'),
                                            Text("${data['user']['nom']} d'email ${data['user']['email']} ?")
                                          ],
                                        ),
                                      ),
                                      actions: [

                                        TextButton(onPressed:() async{


                                          await actionFunction(data['user']['id']);
                                        }, child: const Text("Valider")),

                                        TextButton(onPressed:()async {
                                          Navigator.of(context).pop();
                                        }, child: const Text("Quitter"))
                                      ],
                                    )
                                );

                              }

                            }),
                          ],
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
        )
    );
  }

}

