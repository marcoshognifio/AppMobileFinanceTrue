import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_memoire/get_image.dart';
import 'dart:convert';
import 'button.dart';
import 'entre.dart';
import 'data_class.dart';


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
      body: Center(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    entryfield('Nom','text',RegExp(r'^[a-zA-Z]+([0-9]+)? ?[a-zA-Z]+$'), nomController),
                    entryfield('Quantité de l\'article','text',RegExp(''), quantityController),
                    entryfield('Le prix de l\'article','text',RegExp(r'^[0-9]+$'), priceController),
                    buttonWidget('Valider', actionFunction, context)

                  ]
              ),
            )
        ),
      ),
    );

  }

}














