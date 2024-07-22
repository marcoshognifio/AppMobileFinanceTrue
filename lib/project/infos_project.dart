import 'package:flutter/material.dart';
import 'package:projet_memoire/components/data_class.dart';
import 'package:projet_memoire/components/app_bar.dart';
import 'package:projet_memoire/components/menu.dart';
import 'package:projet_memoire/components/navbar_user.dart';

class  InfoProject extends StatefulWidget {
  const InfoProject({super.key});

  @override
  State<InfoProject> createState() => _InfoProjectState();
}

class _InfoProjectState extends State<InfoProject> {

  
  late Map  project;
  TextStyle titleStyle = const TextStyle(color: Colors.blueAccent,fontSize: 20,fontWeight: FontWeight.bold);
  TextStyle titleLowerStyle = const TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.bold);

  actionFunction() async {

    currentProject = project;
    await DataClass().getUnderProjects(currentProject['id']);
    Navigator.pushNamed(context,'/project/Info');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const NavbarUser(),
        appBar:  const AppBarWidget( menu:'/menuProject' ),
        backgroundColor: Colors.white,
        body:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Text('Infos Projet',style: titleStyle),
              const Divider(height: 20,color: Colors.grey,thickness: 5,),
              Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                padding: const EdgeInsets.only(top: 10),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(child: Text('Nom du projet',style: titleStyle,)),
                    currentProject['nom'].toString().length >20 ?
                    Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(currentProject['nom'].toString(),style: titleLowerStyle,)
                      ),
                    ):Text(currentProject['nom'].toString(),style: titleLowerStyle,)
                  ],
                ),
              ),
              containing('Budget prévu :',"${formatter.format((currentProject['budget_prevu']))} FCFA" ),
              containing('Fond déjà aloué :',"${formatter.format(currentProject['recette_actuelle'])} FCFA"),
              containing('Dépense déjà réalisée :',"${formatter.format(currentProject['depense_actuelle'])} FCFA" ),
              containing('Tansactions :',"${formatter.format(currentProject['transactions'])} FCFA" ),
              containing('Fond restant :',"${formatter.format(currentProject['fond_restant'])} FCFA" ),

              listUnderProjects.isEmpty?
              Container():
              Container(
                child: Column(
                  children: [
                    Text('Les Sous Projets',style: titleStyle),
                    const Divider(height: 20,color: Colors.grey,thickness: 5,),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: listUnderProjects.map<Widget>((project) =>projectWidget(project as Map<String,dynamic>)).toList(),
                ),
              )

            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(0),
            child:MenuWidget(menuOptions: menuProjectItems),
        )
    );
  }//

  Widget containing(String text, var element ){
    TextStyle titleStyle = const TextStyle(color: Colors.blueAccent,fontSize: 20,fontWeight: FontWeight.bold);
    TextStyle titleLowerStyle = const TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.bold);

    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20),
      padding: const EdgeInsets.only(top: 10),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: Text(text,style: titleStyle,)),
          Text(element.toString(),style: titleLowerStyle,)
        ],
      ),
    );
  }
  Widget projectWidget( Map data) {
    project = data;
    return Card(
        margin: const EdgeInsets.all(10),
        elevation: 8,
        color: const Color(0xfff8f8dd),
        child: ListTile(
            leading: Hero(
                tag:"image-project${data['id']}",
                child: Image.asset('images/6.png',width: 100)
            ),
            title:  Text(data['nom'],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text("${data['administrateur_id']}",
                  style: const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 15)
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap:actionFunction
        )
    );
  }
}

