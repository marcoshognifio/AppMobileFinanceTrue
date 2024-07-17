import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_memoire/get_image.dart';
import 'package:projet_memoire/get_list.dart';
import 'dart:convert';
import 'app_bar.dart';
import 'entre.dart';
import 'data_class.dart';


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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  const AppBarWidget( menu:'/menuProject' ),
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
                    getProjectRecipient =  GetList(listItems: DataClass().getItemsUnderProjects()),
                    entryfield('Objet de la transaction','text',RegExp(r''), objectController),
                    entryfield('Montant de la transcation','text',RegExp(r'^[0-9]+\.?[0-9]+$'), montantController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              //fixedSize: const Size(350, 40),
                                elevation: 5,
                                backgroundColor: Colors.blue
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {

                                projectIssuesController =  currentProject['id'];
                                projectRecipientController = getProjectRecipient.getSelectedValue();

                                Map<String,dynamic> request = {
                                  'projet_destinataire_id': "$projectRecipientController",
                                  'montant' : montantController.text,
                                  'objet' : objectController.text,
                                };
                                final uri = Uri.parse("$url/api/projet/$projectIssuesController/save_transaction");
                                final response = await http.post(uri,body : request);


                                final Map<String, dynamic> data = json.decode(response.body);
                                print(data);


                                //Navigator.pushNamed(context,'/user/projects',arguments: data['user']['id']);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text('Valider',style: textStyle),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ]
              ),
            )
        ),
      ),
    );

  }

}
