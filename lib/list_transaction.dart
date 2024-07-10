import 'package:flutter/material.dart';
import 'package:projet_memoire/data_class.dart';

class ListTransaction extends StatefulWidget {
  const ListTransaction({super.key});

  @override
  State<ListTransaction> createState() => ListTransactionState();
}

class ListTransactionState extends State<ListTransaction> {


  @override
  Widget build(BuildContext context) {
    return   Scaffold(

        backgroundColor: Colors.white,
        body: ListView.builder(
            itemCount: listTransaction.length,
            itemBuilder: (context, index){
              return itemList(index as Map<String, dynamic>);
            })
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
            iconColor: Colors.blueAccent,
            collapsedIconColor: Colors.blueAccent,
            childrenPadding:const EdgeInsets.only(right: 10,bottom: 10,left: 20,top: 10),
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
                          Expanded(child: Text(item['projet_destinataire'])),
                        ],
                      ),
                    ),
                  ),
                  Text(item['created_at'])
                ]
            ),
            children: [
              Padding(
                padding:const EdgeInsets.only( bottom: 15.0),
                child: Text(item['objet']),
              ),
              Row(children: [const Text('Montant : '),Text(item['montant']),],
              ),
            ]
          ),
        )
      ),
    );
  }
}
