import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:true_finance/project/get_list.dart';
import 'package:true_finance/components/navbar_user.dart';
import 'dart:convert';
import 'package:true_finance/components/app_bar.dart';
import 'package:true_finance/components/components.dart';
import 'package:true_finance/components/data_class.dart';

import '../components/button.dart';


class TransactionBetweenProjects extends StatefulWidget {
  const TransactionBetweenProjects({super.key});

  @override
  State<TransactionBetweenProjects> createState() => TransactionBetweenProjectsState();
}

class TransactionBetweenProjectsState extends State<TransactionBetweenProjects> {

  int a=0;


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
        body: listUnderProjects.isNotEmpty ? SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Enregistrer une transaltion entre le projet et un de ses sous-projets",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth*0.06,
                      fontStyle: FontStyle.italic),),
              ),
              Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      getProjectRecipient =  GetList(items: DataClass().getItemsUnderProjects()),
                      EntryFieldForm(text: 'Objet de la transaction',type: 'text',express:  RegExp(r''),control: objectController,
                          required: true,error: ''),
                      EntryFieldForm(text: 'Montant de la transaction',type:  'text',express:  RegExp(r'^[0-9]+\.?[0-9]+$'),
                          control:  montantController,required: true,error: 'Entrez une valeur numerique'),
                      ButtonWidget(text:'Valider',onTap: actionFunction),
                    ],
                  ),
                )
              )
            ],
          ),
        ) : emptyPage("Ce projet n'a ni de sous-projet ni de projet parent."
            " Donc la transaction n'est pas possible",Container() ),
    );

  }
}
