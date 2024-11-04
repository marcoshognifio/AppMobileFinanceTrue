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
      fontFamily: 'Roboto-Regular',
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
      
      final response = await http.post(uri,
          headers: {"Content-Type": "application/json","Authorization":"Bearer $token"},
          body : jsonEncode(request));

      final Map<String, dynamic> data = json.decode(response.body);

      Navigator.pushNamed(context,'/user/projects_create');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: const NavbarUser(),
        appBar: const AppBarWidget(menu: '/menuUser'),
        backgroundColor: Colors.white,
        body: listProjectUser.isNotEmpty ? SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Ajouter un fond à un de vos projets",
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
                      getProjectRecipient =  GetList(items: DataClass().getItemsProjectsUser()),
                      EntryFieldForm(text: 'Objet du depot de fond',type: 'text',express:  RegExp(r''),control: objectController,
                          required: true,error: ''),
                      EntryFieldForm(text: 'Montant du fond',type:  'text',express:  RegExp(r'^[0-9]+\.?[0-9]+$'),
                          control:  amountController,required: true,error: 'Entrez une valeur numerique'),
                      ButtonWidget(text:'Valider',onTap: actionFunction),
                    ],
                  ),
                ),
              )
            ],
          ),
        ) : emptyPage("Vous n'avez aucun projet.",Container() )
    );

  }


}














