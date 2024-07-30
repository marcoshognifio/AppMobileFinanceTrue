import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:projet_memoire/project/get_list.dart';
import 'package:projet_memoire/components/navbar_user.dart';
import 'dart:convert';
import 'package:projet_memoire/components/app_bar.dart';
import 'package:projet_memoire/components/components.dart';
import 'package:projet_memoire/components/data_class.dart';

import '../components/button.dart';


class TransactionBetweenProjects extends StatefulWidget {
  const TransactionBetweenProjects({super.key});

  @override
  State<TransactionBetweenProjects> createState() => TransactionBetweenProjectsState();
}

class TransactionBetweenProjectsState extends State<TransactionBetweenProjects> {

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
  final objectController=TextEditingController();
  final montantController = TextEditingController();
  late int projectIssuesController;
  late int projectRecipientController ;
  late GetList getProjectRecipient;

  @override
  void dispose() {
    super.dispose();
    objectController.dispose();
    montantController.dispose();
  }

  actionFunction () async {
    if (formKey.currentState!.validate()) {

      projectIssuesController =  currentProject['id'];
      projectRecipientController = getProjectRecipient.getSelectedValue();

      Map<String,dynamic> request = {
        'projet_destinataire_id': "$projectRecipientController",
        'montant' : montantController.text,
        'objet' : objectController.text,
      };
      final uri = Uri.parse("$url/api/projet/$projectIssuesController/save_transaction");
      final response = await http.post(uri,body : request,headers: {"Content-Type": "application/json","Authorization":"Bearer $token"});


      final Map<String, dynamic> data = json.decode(response.body);


      //Navigator.pushNamed(context,'/user/projects',arguments: data['user']['id']);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        backgroundColor: Colors.white,
        bottomNavigationBar: const NavbarUser(),
        appBar:  const AppBarWidget( menu:'/menuProject' ),
        body: listUnderProjects.isNotEmpty ? Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image:  AssetImage('images/bg1.png'),fit: BoxFit.cover)
          ),
          child: Column(
            children: [
              header(),
              content(),
            ],
          )
        ) : emptyPage("Ce projet n'a ni de sous-projet ni de projet parent."
            " Donc la transaction n'est pas possible",Container() ),
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
                child: Text('Ajouter une transaction',
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
      padding: const EdgeInsets.only(bottom: 20),
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
                  "Enregistrer une transaltion entre le projet et un de ses sous-projets",
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
                      getProjectRecipient =  GetList(items: DataClass().getItemsUnderProjects()),
                      EntryField(text: 'Objet de la transaction',type: 'text',express:  RegExp(r''),control: objectController,
                          required: true,error: ''),
                      EntryField(text: 'Montant de la transaction',type:  'text',express:  RegExp(r'^[0-9]+\.?[0-9]+$'),
                          control:  montantController,required: true,error: 'Entrez une valeur numerique'),
                      ButtonWidget(text:'Valider',onTap: actionFunction),
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
