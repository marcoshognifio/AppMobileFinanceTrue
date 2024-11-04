import 'package:flutter/material.dart';
import 'package:true_finance/components/data_class.dart';
import 'package:true_finance/components/app_bar.dart';
import 'package:true_finance/components/navbar_user.dart';
import '../components/button.dart';
import '../components/components.dart';

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
          future: DataClass().getTransactionsDo(currentProject['id']),
          builder: (BuildContext context,
              AsyncSnapshot<List<dynamic>>snapshot){
            if(snapshot.hasData){

              return listTransactionsGet.isNotEmpty ? ListView.builder(
                  itemCount :listTransactionsDo.length ,
                  itemBuilder:(context, index){
                    return itemList( listTransactionsDo[index] as Map<String, dynamic>,listTransactionsDoAmount[index]);
                  }) : emptyPage("Aucune transaction vers un sous projet n'a été ajoutée",
                  currentProject['administrateur']['id'] == currentUser['id']?
                  ButtonWidget(text: "Ajouter une transaction", onTap:
                      ()async{await Navigator.pushNamed(context,'/project/saveTransaction' );}) :
                      Container());
            }
            else {
              return const CircularProgressIndicator();
            }
          }
      ),
    );
  }

  Widget itemList(Map<String,dynamic> item, Map<String,dynamic> totalAmount){

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
                  leading: SizedBox(width: 50, child: Image.asset('images/6.png',width: 100)),
                  title:  Row(
                      children: [
                        Expanded(child: Text(item['items'][0]['projet_destinataire'],
                              style:const TextStyle(fontFamily: 'Roboto-Regular',color: Colors.black,fontStyle: FontStyle.italic,
                                  fontSize: 16,fontWeight: FontWeight.w900)))
                      ]
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text("${formatter.format(totalAmount['montant_total'])} FCFA",
                        style: const TextStyle(fontFamily: 'Roboto-Regular',color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 15)),
                  ),
                ),
                children: [
                  Padding(
                      padding:const EdgeInsets.only( bottom: 15.0),
                      child:Column(
                        children: columnItemWidget(item['items']),
                      )// articlesList(item['items'])
                  ),
                ]
            ),
          )
      ),
    );
  }

  List<Widget> columnItemWidget(List projects){
    int a = projects.length;
    List<Widget> result =[];

    for(int i=0;i<a;i++){
      result.add(Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.blueAccent))
          ),
          child:articleItem (projects[i] as Map<String,dynamic>)
      )
      );
    }
    return result;
  }


  Widget articleItem(Map<String,dynamic> item){

    return  ListTile(

      title:  Row(
          children: [
            Expanded(child: Text(item['objet'],
                  style:const TextStyle(fontFamily: 'Roboto-Regular',color: Colors.black,fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w900))),
            Text(item['created_at'],style: const TextStyle(fontFamily: 'Roboto-Regular',fontWeight: FontWeight.w900,fontSize: 18,color: Color(
                0xff838080)))
          ]
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text("${formatter.format(item['montant'])} FCFA",
            style: const TextStyle(fontFamily: 'Roboto-Regular',color: Colors.blueAccent,fontWeight: FontWeight.w500,fontSize: 15)),

      ),

    );

  }
}