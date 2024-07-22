import 'package:flutter/material.dart';
import 'package:projet_memoire/components/data_class.dart';
import 'package:projet_memoire/components/navbar_user.dart';

import 'package:projet_memoire/components/app_bar.dart';

class ListTransaction extends StatefulWidget {
  const ListTransaction({super.key});

  @override
  State<ListTransaction> createState() => ListTransactionState();
}

class ListTransactionState extends State<ListTransaction> {


  @override
  Widget build(BuildContext context) {

    return   Scaffold(
      bottomNavigationBar: NavbarUser(),
      appBar:  const AppBarWidget( menu:'/menuProject' ),
        backgroundColor: Colors.white,
        body:FutureBuilder<List<dynamic>>(
            future: DataClass().getTransactions(currentUser['id']),
            builder: (BuildContext context,
                AsyncSnapshot<List<dynamic>>snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount :listTransactionEffect.length ,
                    itemBuilder:(context, index){
                      return itemList( listTransactionEffect[index] as Map<String, dynamic>);
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
      padding: const EdgeInsets.only(left:10,top: 10,bottom: 10,right: 10),
      child: Card(
        margin: const EdgeInsets.all(10),
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
            childrenPadding:const EdgeInsets.only(right: 10,bottom: 10,left: 50,top: 10),
            shape:const Border(),
            title: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/6.png',width: 50),
                          ),
                          Expanded(child: Text(item['projet_destinataire'],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 17),)),
                        ],
                      ),
                    ),
                  ),
                  Text(item['created_at'],style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 14,color: const Color(
                      0xff838080)))
                ]
            ),
            children: [
              Padding(
                padding:const EdgeInsets.only( bottom: 15.0),
                child: Text(item['objet'],style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16)),
              ),
              Row(children: [
                const Text('Montant : ',style:  TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                Text("${item['montant']} FCFA",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: const Color(
                    0xff838080)),),],
              ),
            ]
          ),
        )
      ),
    );
  }
}
