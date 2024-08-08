import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../components/app_bar.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import '../components/get_image.dart';

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
    print("bonjour $amount");
    if(amount< currentProject['recette_actuelle']){
      data["articles"] = listArticles;
      spend['montant'] ="$amount";

      late GetImage getImage;

      showDialog(
          context: context,
          builder: (context) =>AlertDialog(
            title: const Text("Confirmation de la dépense"),
            content:  Column(
              children: [
                EntryField(text:  'Objet de la depense',type: 'text',express: RegExp(r'^[a-zA-Z]+$'),
                  control: objetController,required: true,error: 'Votre entré doit etre constitué de lettre',),
                getImage =  GetImage(textDisplay: 'Ajouter une image(Facultative)',type: 'depense',),
              ],
            ),
            actions: [
              TextButton(onPressed: (){ saveSpend(getImage);}, child: const Text("Valider")),
              TextButton(onPressed:()async {
                Navigator.of(context).pop();
              }, child: const Text("Quitter"))
            ],
          )
      );
    }
    else {
      showDialog(
          context: context,
          builder: (context) =>AlertDialog(
            title: const Text("Confirmation de la dépense"),
            content: const Text('Le fond de votre projet est insuffisant pour enregistrer cette dépense',
                        textAlign: TextAlign.center,),
            actions: [
              TextButton(onPressed:(){Navigator.pop(context);}, child: const Text("Quitter"))
            ],
          )
      );
    }

  }

  saveSpend(GetImage getImage) async {

    spend['objet'] = objetController.text;
    Map body = await getImage.saveImage();
    spend['image'] =  body != {} ? body['path']:"";
    data['depense'] = [spend];
    final uri = Uri.parse("$url/api/projet/${currentProject['id']}/depense/store");
    final response = await http.post(uri,body : jsonEncode(data),headers: {"Content-Type": "application/json","Authorization":"Bearer $token"},);
    data = json.decode(response.body);
    if(data['success'] == true) {
      Navigator.pushNamed(context, '/project/Info');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const AppBarWidget( menu:'/menuProject' ),
      backgroundColor: Colors.white,
      body: listArticles.isNotEmpty ? ListView.builder(
              itemCount :listArticles.length ,
              itemBuilder:(context, index){
                return itemList( listArticles[index]);
                  }
            ): emptyPage("Pas d'articles à ajouter."
          " Appuyez sur le bouton + pour ajouter un article",Container() ),
      floatingActionButton: Padding(
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
          child: Theme(
            data: ThemeData(

              splashColor: Colors.transparent,

              hoverColor: Colors.transparent,),
            child:ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left:10),
              title:  Row(
                  children: [

                    Expanded(child: Text(item['nom'],
                        style:GoogleFonts.lato(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w900))),
                    Padding(
                      padding: const EdgeInsets.only(right:  20.0),
                      child: Text(item['quantite'],style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 15,color: Color(
                          0xff838080))),
                    )
                  ]
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("${formatter.format(double.parse(item['prix']))} FCFA",
                    style: const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 15)),
              ),
            ),
          )
      ),
    );
  }
}

