import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_memoire/data_class.dart';

import 'app_bar.dart';

class ListCosts extends StatefulWidget {
  const ListCosts({super.key});

  @override
  State<ListCosts> createState() => ListCostsState();
}

class ListCostsState extends State<ListCosts> {


  @override
  Widget build(BuildContext context) {

    return   Scaffold(

      appBar:  const AppBarWidget( menu:'/menuProject' ),
      backgroundColor: Colors.white,
      body:FutureBuilder<List<dynamic>>(
          future: DataClass().getCosts(currentUser['id']),
          builder: (BuildContext context,
              AsyncSnapshot<List<dynamic>>snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount :listCostsGet.length ,
                  itemBuilder:(context, index){
                    return itemList( listCostsGet[index] as Map<String, dynamic>);
                  });
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
                childrenPadding:const EdgeInsets.only(right: 10,bottom: 10,top: 10),
                shape:const Border(),
                title: ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  leading: SizedBox(width: 50, child: Image.asset('images/6.png',width: 100)),
                  title:  Row(
                      children: [
                        Expanded(
                          child: Expanded(child: Text(item['objet'],
                              style:GoogleFonts.lato(color: Colors.black,fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w900))),
                        ),
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
                    child: articlesList(item['articles'])
                  ),
                ]
            ),
          )
      ),
    );
  }

  Widget articlesList(List list){
    return SizedBox(
      height: 200,
      child: Expanded(
        child: ListView.builder(
          itemCount: list.length,
            itemBuilder:(context, index){
              return Padding(
                padding: const EdgeInsets.only(right: 10.0,left: 10),
                child: Column(
                  children: [
                    const Divider(height: 20,color: Colors.grey,thickness: 2,),
                    articleItem( list[index] as Map<String, dynamic>),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget articleItem(Map<String,dynamic> item){

      return Column(
        children: [
          Row(
              children: [
                Expanded(
                  child: Expanded(child: Text(item['nom'],
                      style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 17))),
                ),
                Text(item['quantite'],style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 16,color: Color(
                    0xff838080)))
              ]
          ),
          Padding(
            padding: const EdgeInsets.only(top:17.0),
            child: Row(children: [
              const Text('Prix : ',style:  TextStyle(fontWeight: FontWeight.w800,fontSize: 18),),
              Text("${formatter.format(item['prix'])} FCFA",style: const TextStyle(fontWeight: FontWeight.w800,fontSize:18,color: const Color(
                  0xff838080)),),],
            ),
          ),

        ],
      );
  }
}


