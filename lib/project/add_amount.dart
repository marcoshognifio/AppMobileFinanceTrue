import 'dart:convert';
import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import 'package:http/http.dart' as http;

import '../components/navbar_user.dart';
import 'get_list.dart';


class AddAmount extends StatefulWidget {
  const AddAmount({super.key});



  @override
  State<AddAmount> createState() => AddAmountState();
}

class AddAmountState extends State<AddAmount> {

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
  final objectController = TextEditingController();
  final amountController=TextEditingController();
  late int projectRecipientController ;
  late GetList getProjectRecipient;
  //final imageController=TextEditingController();

  @override
  void dispose() {
    super.dispose();
    objectController.dispose();
    amountController.dispose();
  }

  actionFunction() async{
    projectRecipientController= getProjectRecipient.getSelectedValue();
    if (formKey.currentState!.validate() && projectRecipientController >= 0) {

      Map<String,dynamic> request = {
        'projet_destinataire_id': projectRecipientController,
        'montant' : amountController.text,
        'objet' : objectController.text,
      };

      final uri = Uri.parse("$url/api/projet/$projectRecipientController/ajoutfond");
      
      final response = await http.post(uri,body : jsonEncode(request),headers: {"Content-Type": "application/json","Authorization":"Bearer $token"});

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
        bottomNavigationBar: const NavbarUser(),
        appBar: const AppBarWidget(menu: '/menuUser'),
        backgroundColor: Colors.white,
        body: listProjectUser.isNotEmpty ? Container(
          decoration: const BoxDecoration(
             color: Colors.white
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                header('Ajout de Fond à un projet'),
                content("Ajouter de fond à l'un de vos projets ",SizedBox(
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  getProjectRecipient =  GetList(items: DataClass().getItemsProjectsUser()),
                                  EntryField(text: 'Objet du depot de fond',type: 'text',express:  RegExp(r''),control: objectController,
                                      required: true,error: ''),
                                  EntryField(text: 'Montant du fond',type:  'text',express:  RegExp(r'^[0-9]+\.?[0-9]+$'),
                                      control:  amountController,required: true,error: 'Entrez une valeur numerique'),
                                  ButtonWidget(text:'Valider',onTap: actionFunction),
                                ],
                              ),
                            ),
                          )
                        ),
                  ],
            ),
          ),
        ) : emptyPage("Vous n'avez aucun projet.",Container() )
    );

  }


}














