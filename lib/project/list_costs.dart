import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_memoire/components/button.dart';
import 'package:projet_memoire/components/data_class.dart';

import 'package:projet_memoire/components/app_bar.dart';
import 'package:projet_memoire/components/navbar_user.dart';

import '../components/components.dart';

class ListCosts extends StatefulWidget {
  const ListCosts({super.key});

  @override
  State<ListCosts> createState() => ListCostsState();
}

class ListCostsState extends State<ListCosts> {


  @override
  Widget build(BuildContext context) {

    return   Scaffold(
      bottomNavigationBar: const NavbarUser(),
      appBar:  const AppBarWidget( menu:'/menuProject' ),
      backgroundColor: Colors.white,
      body:FutureBuilder<List<dynamic>>(
          future: DataClass().getCosts(currentProject['id']),
          builder: (BuildContext context,
              AsyncSnapshot<List<dynamic>>snapshot){
            if(snapshot.hasData){

              return listCostsGet.isNotEmpty ? ListView.builder(
                  itemCount :listCostsGet.length ,
                  itemBuilder:(context, index){
                    return itemList( listCostsGet[index] as Map<String, dynamic>);
                  }) : emptyPage("Aucune dépense n'a été ajoutée",
                        currentProject['administrateur']['id'] == currentUser['id'] ?
                        ButtonWidget(text: "Ajouter une dépense", onTap:
                            ()async{await Navigator.pushNamed(context,'/project/addSpend' );}) :
                        Container()
                  );
            }
            else {
              return const CircularProgressIndicator();
            }
          }
      ),
    );
  }

  Widget itemList(Map<String,dynamic> item){

    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10,right: 10),
      child: Card(
          margin: const EdgeInsets.only(left:10,top: 10,right: 10,bottom: 10),
          elevation: 8,
          color: const Color(0xfff8f8dd),
          child: Theme(
            data: ThemeData(

              splashColor: Colors.transparent,

              hoverColor: Colors.transparent,),
            child:  ExpansionTile(
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                iconColor: Colors.blueAccent,
                collapsedIconColor: Colors.blueAccent,
                childrenPadding:const EdgeInsets.only(bottom: 10,top: 10),
                shape:const Border(),
                title: ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  leading: SizedBox(width: 50, child: item['image'] != null ?
                  IconButton(
                      icon: Image.network(item['image'],width: 50,height: 50),
                      onPressed: (){
                        listRoutes.add('/displayImage');
                        Navigator.pushNamed(context,'/displayImage',arguments: item['image'] );
                      }
                  ): Image.asset('images/6.png',width: 50)),
                  title:  Row(
                      children: [
                         Expanded(child: Text(item['objet'],
                              style:GoogleFonts.lato(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w900))),

                        Text(item['created_at'],style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 18,color: Color(
                            0xff838080)))
                      ]
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text("${formatter.format(item['montant'])} FCFA",
                        style: const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 15)),
                  ),
                ),
                children: [
                  Padding(
                    padding:const EdgeInsets.only( bottom: 15.0),
                    child: Column(
                      children: columnItemWidget(item['articles']),
                    )
                  ),
                ]
            ),
          )
      ),
    );
  }

  List<Widget> columnItemWidget(List articles){
    int a = articles.length;
    List<Widget> result =[];

    for(int i=0;i<a;i++){
      result.add(Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.blueAccent))
          ),
          child:articleItem (articles[i] as Map<String,dynamic>)
      )
      );
    }
    return result;
  }


  Widget articleItem(Map<String,dynamic> item){

      return ListTile(

        title:  Row(
            children: [
              Expanded(child: Text(item['nom'],
                  style:GoogleFonts.lato(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w900))),
              Text(item['quantite'],style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 18,color: Color(
                  0xff838080)))
            ]
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child:  Text("${formatter.format(item['prix'])} FCFA",
                    style: const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 15)),
        ),

      );
  }

}


