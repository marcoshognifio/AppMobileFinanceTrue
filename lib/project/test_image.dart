import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    
    XFile? a = getImage.getImageFile();
    final uri = Uri.parse("$url/api/save_image");
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', a!.path));
    request.fields['type'] = "project";
    request.headers.addAll( {
      "Authorization": "Bearer $token"
    });
    http.Response response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {

      print(response.body);
    }
    else{
      print("false");
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










