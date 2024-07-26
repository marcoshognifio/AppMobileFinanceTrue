import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import 'package:http/http.dart' as http;

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
    if (formKey.currentState!.validate()) {
      projectRecipientController = getProjectRecipient.getSelectedValue();
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
                  "Ajouter de fond à un projet",
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
                      getProjectRecipient =  GetList(listItems: DataClass().getItemsProjectsUser()),
                      EntryField(text: 'Objet du depot de fond',type: 'text',express:  RegExp(r''),control: objectController,
                          required: true,error: ''),
                      EntryField(text: 'Montant du fond',type:  'text',express:  RegExp(r'^[0-9]+\.?[0-9]+$'),
                          control:  amountController,required: true,error: 'Entrez une valeur numerique'),
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














