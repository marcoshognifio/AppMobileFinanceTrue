

import 'package:flutter/material.dart';
import 'package:projet_memoire/components/app_bar.dart';
import 'package:projet_memoire/components/data_class.dart';
import 'package:projet_memoire/components/navbar_user.dart';

import '../components/menu.dart';

class ListProjectUser extends StatefulWidget {
  ListProjectUser({super.key,required this.listProjectsBuild,required this.showButtonAdd});

  List listProjectsBuild;
  bool showButtonAdd ;
  @override
  State<StatefulWidget> createState() {
    return ListProjectUserState();
  }
}
class ListProjectUserState extends State<ListProjectUser> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavbarUser(),
        appBar: const AppBarWidget( menu: '/menuUser'),
      body: FutureBuilder<List<dynamic>>(
        future: DataClass().getProjectsUser(currentUser['id']),
        builder: (BuildContext context,
            AsyncSnapshot<List<dynamic>>snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount :listProjectUser.length,
                    itemBuilder:(context, index){
                    return ProjectWidget(data: listProjectUser[index] as Map<String,dynamic>);
                    });
              }
              else {
                return const CircularProgressIndicator();
              }
        }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatButton(controller:  widget.showButtonAdd),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: MenuWidget( menuOptions: menuUserItems)
            ),
          ],
        ),
      ) ,
      );
  }
}


class FloatButton extends StatefulWidget {
  FloatButton({super.key,required this.controller});
  bool controller;

  @override
  State<FloatButton> createState() => _FloatButtonState();
}

class _FloatButtonState extends State<FloatButton> {
  @override
  Widget build(BuildContext context) {
    return  Visibility(
      visible: widget.controller,
      child: FloatingActionButton(
        heroTag: 'btn2',
        backgroundColor: Colors.blueAccent ,
        onPressed:(){ Navigator.pushNamed(context,'/project/addProject');},
        child: const Icon(Icons.add,color:  Color(0xfff8f8dd),weight: 600,size: 20,),
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
    return Card(
        margin: const EdgeInsets.all(10),
        elevation: 8,
        color: const Color(0xfff8f8dd),
        child: ListTile(
          leading: Hero(
              tag:"image-project${widget.data['id']}",
              child: Image.asset('images/6.png',width: 100)
          ),
          title:  Text(widget.data['nom'],
            style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 20),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(

              children: [
                const Text("Recette actuelle : ",style: TextStyle(
                    color: Colors.black,fontSize: 15)),
                const SizedBox(width: 10,),
                Text("${formatter.format(widget.data['recette_actuelle'])} FCFA",
                    style: const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 15)),
              ],
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          onTap:actionFunction,
        )
    );
  }
}



