import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import '../components/navbar_user.dart';


class AddArticle extends StatefulWidget {
  const AddArticle({super.key});



  @override
  State<AddArticle> createState() => AddArticleState();
}

class AddArticleState extends State<AddArticle> {

  int a = 0;
  TextStyle textStyle = const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      height: 2,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      wordSpacing: 10,
      letterSpacing: 3
  );

  final formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nomController.dispose();
    quantityController.dispose();
    priceController.dispose();
  }

  actionFunction() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> article = {
        'nom': nomController.text,
        'quantite': quantityController.text,
        'prix': priceController.text,
      };

      listArticles.add(article);
      Navigator.pushNamed(context, '/project/addSpend');
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
        body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Ajouter un article a votre catalogue de dépense",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth*0.045,
                        fontStyle: FontStyle.italic),),
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        EntryFieldForm(text: 'Nom',
                            type: 'text',
                            express: RegExp(r'^[a-zA-Z ]+[a-zA-Z0-9 ]+$'),
                            control: nomController,
                            required: true,
                            error: 'le nom entré n\'est pas valide'),
                        EntryFieldForm(text: 'Quantité de l\'article',
                            type: 'text',
                            express: RegExp(''),
                            control: quantityController,
                            required: true,
                            error: ''),
                        EntryFieldForm(text: 'Le prix de l\'article',
                            type: 'text',
                            express: RegExp(r'^[0-9]+(.)?[0-9]+$'),
                            control: priceController,
                            required: true,
                            error: 'Entrez une valeurs numerique'),
                        ButtonWidget(
                            text: 'Enregistrer', onTap: actionFunction),
                      ],
                    ),
                  ),
              ],
            ),
        )
    );
  }


}