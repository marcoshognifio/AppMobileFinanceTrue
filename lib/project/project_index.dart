import 'package:flutter/material.dart';
import 'package:projet_memoire/components/app_bar.dart';
import 'package:projet_memoire/components/data_class.dart';
import 'package:projet_memoire/components/navbar_user.dart';

class ListUnderProject extends StatefulWidget {
  const ListUnderProject({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListUnderProjectState();
  }
}
class ListUnderProjectState extends State<ListUnderProject> {

  late Map project;
   actionFunction() async {

    currentProject = project;
    Navigator.pushNamed(context,'/project/underProjects');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavbarUser(),
      appBar: const AppBarWidget( menu:'/menuProject' ),
      body: FutureBuilder<List<dynamic>>(
          future: DataClass().getUnderProjects(currentProject['id']),
          builder: (BuildContext context,
              AsyncSnapshot<List<dynamic>>snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount :listUnderProjects.length ,
                  itemBuilder:(context, index){
                    return projectWidget(listUnderProjects[index] as Map<String,dynamic>);
                  });
            }
            else {
              return const CircularProgressIndicator();
            }
          }),
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


