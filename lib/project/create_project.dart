import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import 'package:http/http.dart' as http;


class AddProject extends StatefulWidget {
  const AddProject({super.key});



  @override
  State<AddProject> createState() => AddProjectState();
}

class AddProjectState extends State<AddProject> {

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
  final descriptionController = TextEditingController();
  final budgetController=TextEditingController();
  //final imageController=TextEditingController();
  final dateEndController=TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nomController.dispose();
    descriptionController.dispose();
    budgetController.dispose();
    dateEndController.dispose();
  }

  actionFunction() async{
    if (formKey.currentState!.validate()) {

      Map<String,dynamic> project ={};
      project['nom'] = nomController.text;
      descriptionController.text.isNotEmpty?project['description']=descriptionController.text:true==true;
      budgetController.text.isNotEmpty?project['budget_prevu']=budgetController.text:true==true;
      dateEndController.text.isNotEmpty?project['date_fin']=dateEndController.text:true==true;
      project['createur_id'] = currentUser['id'];
      project['administrateur_id'] = currentProject['id'];

      final uri = Uri.parse("$url/api/projet/create_projet");
      final response = await http.post(uri,body : project);
      print(response.body);

      final Map<String, dynamic> data = json.decode(response.body);

      Navigator.pushNamed(context,'/user/projects_create');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image:  AssetImage('images/bg1.png'),fit: BoxFit.cover)
          ),
          child: Column(
            children: [
              header(),
              content(),
            ],
          ),
        )
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
                child: Text('Ajouter un Project',
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Ajouter un Project a votre catalogue de dépense",
                  style: GoogleFonts.actor(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      fontStyle: FontStyle.italic),),
              ),
              SizedBox(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      EntryField( text: 'Nom du projet',type: 'text',express:  RegExp(r'^[a-zA-Z]+([0-9]+)?[a-zA-Z]+$'),
                                  control: nomController,required: true,error: 'Entre invalide'),
                      EntryField( text: 'Description du projet(Facultative)',type:  'text',express:  RegExp(''),
                                  control:  descriptionController,required: false,error: ''),
                      EntryField(text:  'Le budget prevu(Facultative)',type:  'text',express: RegExp(r'^[0-9]+(.)?[0-9]+$'),
                                  control: budgetController,required: false,error:  'Entrez une valeur numerique'),
                      EntryField(text: 'Date fin projet(Facultative)',type: 'text',express: RegExp(''),
                                  control: descriptionController,required: false,error:  ''),
                      buttonWidget('Se connecter', actionFunction, context),
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
}














