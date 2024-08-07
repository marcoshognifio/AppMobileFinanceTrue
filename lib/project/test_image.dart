import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import 'package:http/http.dart' as http;
import '../components/get_image.dart';
import '../components/navbar_user.dart';


class AddImage extends StatefulWidget {
  const AddImage({super.key});



  @override
  State<AddImage> createState() => AddImageState();
}

class AddImageState extends State<AddImage> {

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
  late GetImage getImage;
  final imageController=TextEditingController();

  @override
  void dispose() {
    super.dispose();
    imageController.dispose();
  }

  actionFunction() async{



    //Response response = await dio.post(, data: formData);
    //{"Content-Type": "multipart/form-data","Authorization":"Bearer $token"}


    /*if (response.statusCode == 200) {
     print(response.statusMessage);
      print("Image téléchargée avec succès");
    } else {

      print("Erreur lors du téléchargement de l'image");
    }*/
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
        body: Container(
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
                        getImage =  GetImage(textDisplay: 'Choisissez une image'),

                        ButtonWidget(text:'Valider',onTap: actionFunction),
                      ],
                    ),
                  ),
                )
                ),
              ],
            ),
          ),
        )
    );

  }


}










