import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_memoire/components/data_class.dart';
import 'package:projet_memoire/components/app_bar.dart';
import 'package:projet_memoire/components/menu.dart';
import 'package:projet_memoire/components/navbar_user.dart';

class  InfoProjectNew extends StatefulWidget {
  const InfoProjectNew({super.key});

  @override
  State<InfoProjectNew> createState() => _InfoProjectNewState();
}

class _InfoProjectNewState extends State<InfoProjectNew> {


  late Map  project;
  TextStyle titleUpStyle = GoogleFonts.lato(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w900);
  TextStyle titleStyle = GoogleFonts.lato(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w900);
  TextStyle titleLowerStyle = const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 15);

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
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
              Card(
                shape:  RoundedRectangleBorder(
                  borderRadius:  BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Colors.blueAccent,
                    width: 1
                  )
                ),
                margin: const EdgeInsets.all(10),
                elevation: 8,
                color: const Color(0xfff8f8dd),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding:const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color:Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                    topLeft:Radius.circular(10),
                                    topRight: Radius.circular(10)
                                  ),
                              ),
                              child: Text('Infos Projet',style: titleUpStyle)
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 20),
                      padding: const EdgeInsets.only(top: 10),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: Text('Nom du projet',style: titleStyle,)),
                          currentProject['nom'].toString().length >20 ?
                          SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(currentProject['nom'].toString(),style: titleLowerStyle,)
                            ) :Text(currentProject['nom'].toString(),style: titleLowerStyle,)
                        ],
                      ),
                    ),
                    containing('Budget prévu :',"${formatter.format((currentProject['budget_prevu']))} FCFA" ),
                    containing('Fond déjà aloué :',"${formatter.format(currentProject['recette_actuelle'])} FCFA"),
                    containing('Dépense déjà réalisée :',"${formatter.format(currentProject['depense_actuelle'])} FCFA" ),
                    containing('Tansactions :',"${formatter.format(currentProject['transactions'])} FCFA" ),
                    containing('Fond restant :',"${formatter.format(currentProject['fond_restant'])} FCFA" ),
                  ],
                ),
              ),
              listUnderProjects.isEmpty?
              Container():
              Card(
                shape:  RoundedRectangleBorder(
                    borderRadius:  BorderRadius.circular(10),
                    side: const BorderSide(
                        color: Colors.blueAccent,
                        width: 1
                    )
                ),
                margin: const EdgeInsets.all(10),
                elevation: 8,
                color: const Color(0xfff8f8dd),
                child: Column(
                  children: columnItemWidget(listUnderProjects)
                ),
              )

            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(0),
          child:MenuWidget(menuOptions: currentProject['administrateur']['id'] == currentUser['id'] ?
          menuAdminProjectItems:menuCreatorProjectItems),
        )
    );
  }//

  List<Widget> columnItemWidget(List projects){
    int a = projects.length-1;
    List<Widget> result =[];
    result.add(

        Row(
          children: [
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  padding:const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color:Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                        topLeft:Radius.circular(10),
                        topRight: Radius.circular(10)
                    ),
                  ),
                  child: Text('Les sous projets',style: titleUpStyle)
              ),
            ),
          ],
        )
    );
    for(int i=0;i<a;i++){
      result.add(Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.blueAccent))
          ),
          child: ProjectWidget(data:  projects[i] as Map<String,dynamic>)
        )
      );
    }
    result.add(ProjectWidget(data:  projects[a] as Map<String,dynamic>));
    return result;
  }
  
  Widget containing(String text, var element ){


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
}

class ProjectWidget extends StatefulWidget {
  const ProjectWidget({super.key,required this.data});
  final  Map<String,dynamic> data;
  @override
  State<ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {

  actionFunction() async {
    currentProject = widget.data;
    await DataClass().getUnderProjects(currentProject['id']);
    Navigator.pushNamed(context,'/project/Info');
  }
  @override
  Widget build(BuildContext context) {
    return  ListTile(
          leading: Hero(
              tag:"image-project${widget.data['id']}",
              child: Image.asset('images/6.png',width: 100)
          ),
          title:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(widget.data['nom'],
              style: GoogleFonts.lato(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w900),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text("${formatter.format(widget.data['recette_actuelle'])} FCFA",
                style: const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 15)),

          ),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          onTap:actionFunction,
        );
  }
}
