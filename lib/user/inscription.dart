import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:true_finance/components/get_image.dart';
import 'dart:convert';
import 'package:true_finance/components/button.dart';
import 'package:true_finance/components/components.dart';
import 'package:true_finance/components/data_class.dart';


class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => InscriptionPageState();
}

class InscriptionPageState extends State<InscriptionPage> {

  int a=0;
  TextStyle textStyle=const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      height: 2,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      wordSpacing: 10,
      letterSpacing: 3
  );

  TextStyle textLogin = const TextStyle(
    fontFamily: 'Roboto',
    color: Colors.white,
    fontSize: 30,
    wordSpacing: 5,
    fontWeight: FontWeight.bold,
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
      backgroundColor: Colors.transparent,
      body: Container(
          decoration: BoxDecoration(
            image:DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
                    BlendMode.darken),
                image: const AssetImage('assets/images/background.jpg'),
                fit: BoxFit.fill),

          ),
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30,bottom: 30),
                  child: SizedBox(
                    width: screenWidth - 70,
                    child: Column(
                        children: [
                          Text("Bienvenu sur Finance True",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: screenWidth*0.06,
                              wordSpacing: 5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Inscrivez vous pour bénéficier des services de notre application",
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),
                  ),
                ),
                content(),

              ],
            ),

      ),
    ) ;
  }

  Widget content() {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              EntryField(text:  'Nom',type:  'text',express:  RegExp(r''),
                control:  nomController,required:  true,error:  '', icon: const Icon(Icons.person),),

              EntryField(text: 'telephone',type: 'text',express: RegExp(r'^[0-9]+$'),
                control: telephoneController,required: true,error:  'Entrez des valeurs numeriques', icon: const Icon(Icons.numbers),),

              EntryField(text:  'votre email', type: 'email',
                express:  RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                control:  emailController,required:  true,error:  '', icon: const Icon(Icons.email),),

              EntryField(text:  'votre mot de passe',type:  'password',express:  RegExp(''),
                control:  passwordController,required: true,error:  '', icon: const Icon(Icons.lock),),
            ],
          ),
        ),
        ButtonWidget(text: 'S\'inscrire',onTap:  actionFunction),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Avez vous un compte ?",style: TextStyle(fontFamily: 'Roboto-Regular',color: Colors.white),),
              TextButton(
                  onPressed: () {Navigator.pushNamed(context, '/login');},
                  child: const Text('Connectez-vous',
                    style: TextStyle(
                        color: Colors.blueAccent),))
            ],
          ),
        )
      ],
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
                      fontFamily: 'Roboto-Regular',
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






































