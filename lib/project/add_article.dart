import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';


class AddArticle extends StatefulWidget {
  const AddArticle({super.key});



  @override
  State<AddArticle> createState() => AddArticleState();
}

class AddArticleState extends State<AddArticle> {

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
  final quantityController = TextEditingController();
  final priceController=TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nomController.dispose();
    quantityController.dispose();
    priceController.dispose();
  }

  actionFunction() async{
    if (formKey.currentState!.validate()) {

      Map<String,dynamic> article = {
        'nom' : nomController.text,
        'quantite' : quantityController.text,
        'prix' : priceController.text,
      };

      listArticles.add(article);
      print(listArticles);
      Navigator.pushNamed(context,'/project/addSpend');
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
                child: Text('Ajouter un article',
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
                  "Ajouter un article a votre catalogue de dépense",
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
                      entryField('Nom','text',RegExp(r'^[a-zA-Z]+([0-9]+)? ?[a-zA-Z]+$'),
                          nomController),
                      entryField('Quantité de l\'article','text',RegExp(''), quantityController),
                      entryField('Quantité de l\'article','text',RegExp(''), quantityController),
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














