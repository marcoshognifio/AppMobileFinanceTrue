

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_memoire/app_bar.dart';
import 'package:projet_memoire/data_class.dart';

class ListProjectUser extends StatefulWidget {
  const ListProjectUser({super.key});
  @override
  State<StatefulWidget> createState() {
    return ListProjectUserState();
  }
}
class ListProjectUserState extends State<ListProjectUser> {

  @override
  void initState() {
    super.initState();
    DataClass().getProjectsUser(currentUser['id']);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget( menu: '/menuUser'),
      body: FutureBuilder<List<dynamic>>(
        future: DataClass().getProjectsUser(currentUser['id']),
        builder: (BuildContext context,
            AsyncSnapshot<List<dynamic>>snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount :listProjectUser.length ,
                    itemBuilder:(context, index){
                    return ProjectWidget(data: listProjectUser[index] as Map<String,dynamic>);
                    });
              }
              else {
                return const CircularProgressIndicator();
              }
        }),
      );
  }
}

class ProjectWidget extends StatelessWidget {

  const ProjectWidget({super.key,required this.data});
  final  Map<String,dynamic> data;
  final Color color=Colors.blue;
  @override
  Widget build(BuildContext context) {

    return  Card(
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
                  style: const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 15)),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap:() {
                  currentProject = data;
                  Navigator.pushNamed(context,'/project/underProjects');
              },
        )
    );

  }

}
