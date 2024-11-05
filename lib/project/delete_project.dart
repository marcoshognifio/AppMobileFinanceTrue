import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:true_finance/components/components.dart';
import 'package:true_finance/project/get_list.dart';
import 'package:true_finance/components/navbar_user.dart';
import 'dart:convert';
import 'package:true_finance/components/app_bar.dart';
import 'package:true_finance/components/data_class.dart';

import '../components/button.dart';


class DeleteProject extends StatefulWidget {
  const DeleteProject({super.key});

  @override
  State<DeleteProject> createState() => DeleteProjectState();
}

class DeleteProjectState extends State<DeleteProject> {

  int a = 0;
  TextStyle textStyle = const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      height: 2,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      wordSpacing: 10,
      letterSpacing: 3
  );

  final formKey = GlobalKey<FormState>();
  late int projectController;

  late GetList getProjectRecipient;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const NavbarUser(),
        appBar: const AppBarWidget(menu: '/menuProject'),
        backgroundColor: Colors.white,
        body: listProjectUser.isNotEmpty ? SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Supprimer un de vos projets',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth*0.045,
                        fontStyle: FontStyle.italic
                    ),
                  ),
              ),
              Center(
                child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getProjectRecipient =  GetList(items: DataClass().getItemsProjectsUser()),
                            ButtonWidget(text: 'Valider',onTap: ()async{
                              projectController = getProjectRecipient.getSelectedValue();
                              if (formKey.currentState!.validate() && projectController >= 0)
                              {
                                await showDialog(
                                    context: context,
                                    builder: (context) =>AlertDialog(
                                      title: const Text("Confirmation de la supresseion"),
                                      content:  Container(
                                        height: 200,
                                        child: const Column(
                                          children: [
                                            Text('Confirmer la suppression de ce projet',style: TextStyle(fontFamily: 'Roboto',),),
                                          ],
                                        ),
                                      ),
                                      actions: [

                                        TextButton(onPressed:() async{
                                          Map<String,dynamic>  user = {
                                            'projet_id':projectController ,
                                          };
                                          final uri = Uri.parse("$url/api/projet/delete");
                                          final response = await http.post(uri,body : jsonEncode(user),
                                              headers: {"Content-Type": "application/json","Authorization":"Bearer $token"});
                                          Map<String,dynamic> data = json.decode(response.body);

                                          if(data['success'] == true ){
                                            await Navigator.pushNamed(context, '/user/projects_create');
                                          }
                                        }, child: const Text("Valider",style: TextStyle(fontFamily: 'Roboto',),)),

                                        TextButton(onPressed:()async {
                                          Navigator.of(context).pop();
                                        }, child: const Text("Quitter",style: TextStyle(fontFamily: 'Roboto',),))
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
            ],
          ),
        ) : emptyPage("Vous n'avez aucun projet à supprimer.",Container() ),
    );
  }
}

