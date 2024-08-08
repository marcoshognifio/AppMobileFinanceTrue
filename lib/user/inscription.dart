import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:projet_memoire/components/get_image.dart';
import 'dart:convert';
import 'package:projet_memoire/components/button.dart';
import 'package:projet_memoire/components/components.dart';
import 'package:projet_memoire/components/data_class.dart';


class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => InscriptionPageState();
}

class InscriptionPageState extends State<InscriptionPage> {

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
  final telephoneController = TextEditingController();
  final emailController=TextEditingController();
  final passwordController = TextEditingController();
  late String imageController;
  late GetImage getImage;

  @override
  void dispose() {
    super.dispose();
    nomController.dispose();
    telephoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  actionFunction() async{

    if (formKey.currentState!.validate()) {

      Map body = await getImage.saveImage();
      imageController =  body != {} ? body['path']:"";

      imageController = body['path'];
      Map<String,dynamic> data = {
        'name': nomController.text,
        'telephone': telephoneController.text,
        'email': emailController.text,
        'password': passwordController.text,
      };
      data['image'] = imageController != "" ? imageController : true == true;


      Uri uri = Uri.parse("$url/api/user/save_user");

      final response = await http.post(uri,
          body : jsonEncode(data),
          headers: {"Content-Type": "application/json","Authorization":"Bearer $token"}
      );
      data = json.decode(response.body);

      if(data['success'] == true){
        await Navigator.pushNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image:  AssetImage('images/bg1.png'),fit: BoxFit.cover)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                header(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: content(),
                ),
              ],
            ),
          ),
      ),
    );
  }

  Widget content() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white.withOpacity(0.15),),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xff7a91f8).withOpacity(1),Colors.white.withOpacity(0.3)]
          )

      ),
      child: Column(
        children: [
          Center(child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 130,
                    width: 130,
                    child: Center(
                        child: Image.asset('images/Logo5.png', width: 130)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Inscrivez vous pour bénéficier des services de notre application",
                      style: GoogleFonts.actor(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          fontStyle: FontStyle.italic),),
                  ),
                ],
              ),
              SizedBox(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      EntryField(text:  'Nom',type:  'text',express:  RegExp(r''),
                          control:  nomController,required:  true,error:  ''),
                      EntryField(text: 'telephone',type: 'text',express: RegExp(r'^[0-9]+$'),
                          control: telephoneController,required: true,error:  'Entrez des valeurs numeriques'),
                      EntryField(text:  'votre email', type: 'email',
                          express:  RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                          control:  emailController,required:  true,error:  ''),
                      getImage =  GetImage(textDisplay: 'Choisissez une image',type: 'user',),
                      EntryField(text:  'votre mot de passe',type:  'password',express:  RegExp(''),
                         control:  passwordController,required: true,error:  ''),

                      Column(
                        children: [
                          ButtonWidget(text: 'S\'inscrire',onTap:  actionFunction),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Avez vous un compte ?"),
                                TextButton(
                                    onPressed: () {Navigator.pushNamed(context, '/login');},
                                    child: const Text('Connectez-vous',
                                      style: TextStyle(
                                          color: Colors.blueAccent),))
                              ],
                            ),
                          )
                        ],
                      )
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

  Widget header() {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 20,left: 20,right: 20),
      margin: const EdgeInsets.all(15),
      child: const Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top:10, bottom: 10.0),
            child: Row(children: [
              Icon(Icons.label_important, color: Colors.white,),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('Inscrivez-vous',
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

}






































