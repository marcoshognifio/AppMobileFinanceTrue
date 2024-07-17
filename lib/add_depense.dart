import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_memoire/data_class.dart';
import 'package:http/http.dart' as http;
import 'entre.dart';
import 'app_bar.dart';

class AddSpent extends StatefulWidget {
  const AddSpent({super.key});

  @override
  State<AddSpent> createState() => AddSpentState();
}

class AddSpentState extends State<AddSpent> {

  Map<String,dynamic> data = {},spend={};
  final objetController=TextEditingController();

  @override
  void dispose() {
    super.dispose();
    objetController.dispose();
  }

  addFunction(){
    double amount = 0;
    for(int i=0,c=listArticles.length;i<c;i++){
          amount = amount + double.parse(listArticles[i]['prix']);
      }
    if(amount< currentProject['budget']){
      data["articles"] = listArticles;
      spend['montant'] ="$amount";
    }

    showDialog(
        context: context,
        builder: (context) =>AlertDialog(
          title: const Text("Confirmation de la dépense"),
          content:  entryfield('Objet de la depense','text',RegExp(r'^[a-zA-Z]+$'), objetController),
          actions: [
            TextButton(onPressed: saveSpend, child: const Text("Valider"))
          ],
        )
    );
  }

  saveSpend() async {

    spend['objet'] = objetController.text;
    data['depense'] = [spend];
    final uri = Uri.parse("$url/api/projet/${currentProject['id']}/depense/store");
    final response = await http.post(uri,body : jsonEncode(data),headers: {"Content-Type": "application/json"},);
    print(json.decode(response.body));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const AppBarWidget( menu:'/menuProject' ),
      backgroundColor: Colors.white,
      body:ListView.builder(
              itemCount :listArticles.length ,
              itemBuilder:(context, index){
                return itemList( listArticles[index] as Map<String, dynamic>);
                  }
            ),
      floatingActionButton:  Padding(
        padding: const  EdgeInsets.only(left: 30.0) ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

          FloatingActionButton(
            backgroundColor: Colors.blueAccent ,
            onPressed: addFunction ,
            heroTag: "btn1",
            child: const Icon(Icons.save_alt,color:  Color(0xfff8f8dd),weight: 600,size: 25,),
          ),

          FloatingActionButton(
            backgroundColor: Colors.blueAccent ,
            onPressed:(){ Navigator.pushNamed(context,'/project/addArticle');},
            heroTag: "btn2",
            child: const Icon(Icons.add,color:  Color(0xfff8f8dd),weight: 600,size: 25,),
          ),
        ],),
      )

    );
  }

  Widget itemList(Map<String,dynamic> item){

    return Padding(
      padding: const EdgeInsets.only(left:10,top: 10,bottom: 10,right: 10),
      child: Card(
          margin: const EdgeInsets.all(10),
          elevation: 8,
          color: const Color(0xfff8f8dd),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                    children: [
                      Expanded(
                        child: Expanded(child: Text(item['nom'],
                          style:GoogleFonts.lato(color: Colors.lightBlue,fontStyle: FontStyle.italic,fontSize: 22,fontWeight: FontWeight.w900))),
                      ),
                      Text(item['quantite'],style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 18,color: Color(
                          0xff838080)))
                    ]
                ),
                Padding(
                  padding: const EdgeInsets.only(top:17.0),
                  child: Row(children: [
                    const Text('Prix : ',style:  TextStyle(fontWeight: FontWeight.w800,fontSize: 20),),
                    Text("${formatter.format(int.parse(item['prix']))} FCFA",style: const TextStyle(fontWeight: FontWeight.w800,fontSize:18,color: const Color(
                        0xff838080)),),],
                  ),
                ),

              ],
            ),
          ),
      ),
    );
  }
}
