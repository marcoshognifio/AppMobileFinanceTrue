import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_memoire/components/data_class.dart';

import 'package:projet_memoire/components/app_bar.dart';
import 'package:projet_memoire/components/navbar_user.dart';

class ListTransactionsDo extends StatefulWidget {
  const ListTransactionsDo({super.key});

  @override
  State<ListTransactionsDo> createState() => ListTransactionsDoState();
}

class ListTransactionsDoState extends State<ListTransactionsDo> {


  @override
  Widget build(BuildContext context) {

    return   Scaffold(
      bottomNavigationBar: const NavbarUser(),
      appBar:  const AppBarWidget( menu:'/menuProject' ),
      backgroundColor: Colors.white,
      body:FutureBuilder<List<dynamic>>(
          future: DataClass().getTransactionsDo(currentUser['id']),
          builder: (BuildContext context,
              AsyncSnapshot<List<dynamic>>snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount :listTransactionsDo.length ,
                  itemBuilder:(context, index){
                    return itemList( listTransactionsDo[index] as Map<String, dynamic>,listTransactionsDoAmount[index]);
                  });
            }
            else {
              return const CircularProgressIndicator();
            }
          }
      ),
    );
  }

  Widget itemList(Map<String,dynamic> item, Map<String,dynamic> totalAmount){
    print(item);
    print(totalAmount);
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
                        Expanded(child: Text(item['items'][0]['projet_destinataire'],
                              style:GoogleFonts.lato(color: Colors.black,fontStyle: FontStyle.italic,
                                  fontSize: 16,fontWeight: FontWeight.w900)))
                      ]
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text("${formatter.format(totalAmount['montant_total'])} FCFA",
                        style: const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 15)),
                  ),
                ),
                children: [
                  Padding(
                      padding:const EdgeInsets.only( bottom: 15.0),
                      child: articlesList(item['items'])
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
    );
  }

  Widget articleItem(Map<String,dynamic> item){
    print(item);
    return Column(
      children: [
        Row(
            children: [
              Expanded(child: Text(item['objet'],
                    style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 17))),

              Text(item['created_at'],style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 16,color: Color(
                  0xff838080)))
            ]
        ),
        Padding(
          padding: const EdgeInsets.only(top:17.0),
          child: Row(children: [
            Text("${formatter.format(item['montant'])} FCFA",style: const TextStyle(fontWeight: FontWeight.w800,fontSize:18,color:  Color(
                0xff838080)),),],
          ),
        ),

      ],
    );
  }
}